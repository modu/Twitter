//
//  Tweet.swift
//  Twitter
//
//  Created by Varun Vyas on 06/02/16.
//  Copyright © 2016 Varun Vyas. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var userName: String?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var profile_image_url: String?
    var screen_name :String?
    
    var favCount: Int?
    var retweetCount: Int?
    var tweetId: String?

    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        profile_image_url = dictionary["profile_image_url"] as? String
        userName = dictionary["name"] as? String
        screen_name = dictionary["screen_name"] as? String
        favCount = dictionary["favorite_count"] as? Int
        retweetCount = dictionary["retweet_count"] as? Int
        tweetId = dictionary["id_str"] as? String

        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
    }
    
    class func tweetswithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
    
}