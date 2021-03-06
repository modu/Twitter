//
//  TwitterClient.swift
//  Twitter
//
//  Created by Varun Vyas on 04/02/16.
//  Copyright © 2016 Varun Vyas. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "vy9rCAHE4Y3Or8cQX9Y4z4yZh"
let twitterConsumerSecret = "9qZLv8uNbxJB0KmIt3A4DXvIyN4KNHupPT7qf4qqD30Z0CeVVf"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    func getUrl() -> NSURL {
        var authURL :NSURL?
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token")
            authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            }) { (error: NSError!) -> Void in
                print("Error getting request token: \(error)")
                self.loginCompletion?(user: nil, error: error)
        }
        
        return authURL!
        
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            }) { (error: NSError!) -> Void in
                print("Error getting request token: \(error)")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func openURL(url: NSURL) {
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Got access token")
            
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("It worked!!!")
                
                let user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print("user: \(user.name)")
                self.loginCompletion?(user:user, error: nil)
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                    print("It did not work")
                    self.loginCompletion?(user: nil, error: error)
                    
            })
            
            }) { (error: NSError!) -> Void in
                print("An error occurred")
                self.loginCompletion?(user: nil, error: error)
        }
        
    }
    
    func homeTimeline(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()){
        var tweets :[Tweet]?
        
        TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
//            print("It worked!!!")
//            print("user: \(response)")
            tweets = Tweet.tweetswithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)

            //            print("*************\n\n Returned from Tweeter ****************")
//            print(response)
//            for tweet in tweets! {
//                print("text: \(tweet.text), created: \(tweet.createdAt)")
//                print("name: \(tweet.user),  :createdAtString \(tweet.createdAtString) ")
//            }
//            print("After gethomTimeLine ")
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("It did not work")
                self.loginCompletion?(user: nil, error: error)
                
        })
        }
    
    func retweet(tweetId: String) {
        
        TwitterClient.sharedInstance.POST("1.1/statuses/retweet/\(tweetId).json", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("successful retweet")
            }) { (opreation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("can't retweet")
        }
    }
    
    func favorite(tweetId: String) {
        
        TwitterClient.sharedInstance.POST("1.1/favorites/create.json?id=\(tweetId)", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("successful fav")
            }) { (opreation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("can't fav")
        }
    }
    
    func reply(text: String, statusId: String) {
        var escapedText = text.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        print("1.1/statuses/update.json?status=\(escapedText!)?in_reply_to_status_id=\(statusId)")
        TwitterClient.sharedInstance.POST("1.1/statuses/update.json?status=\(escapedText!)&in_reply_to_status_id=\(statusId)", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("successful reply")
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("can't reply")
        }
        
    }
    
    func getProfile(screenName: String!) {
        TwitterClient.sharedInstance.GET("1.1/users/show.json?screen_name=\(screenName!)", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Successfully got user")
            print("\(response)")
            
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Can't get user")
        }
        
    }

    func makeTweet(text: String) {
        var escapedText = text.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        TwitterClient.sharedInstance.POST("1.1/statuses/update.json?status=\(escapedText!)", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("successful tweet")
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("can't tweet")
        }
        
    }

    
    
}
