//
//  DetailsViewController.swift
//  Twitter
//
//  Created by Varun Vyas on 14/02/16.
//  Copyright © 2016 Varun Vyas. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var realName: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var tweetText: UILabel!
    
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    
    @IBOutlet weak var likesCount: UILabel!
    
    @IBOutlet weak var likeslabel: UILabel!
    
    @IBOutlet weak var timeDate: UILabel!
    
    @IBOutlet weak var replyText: UITextField!
    
    @IBOutlet weak var replyButton: UIButton!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        replyText.hidden = true
        replyText.text = "Empty"
        print("Details View controller " )
        realName.text = tweet.user?.name
        userName.text = tweet.user?.screenName
        tweetText.text = tweet.text
        retweetLabel.text = ""
        likeslabel.text = ""
        retweetCount.text = ""
        likesCount.text = ""
        if tweet.retweetCount > 0 {
            retweetCount.text = String(tweet.retweetCount!)
            retweetLabel.text = "Retweets"
        }
        if tweet.favCount > 0 {
            likesCount.text = String(tweet.favCount!)
            likeslabel.text = "Likes"
        }
        timeDate.text = tweet.createdAtString
        profileImageView.setImageWithURL(NSURL(string: tweet.user!.profileImageURL!)!)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func replyButtonClicked(sender: AnyObject) {
        
        if(replyText.text == "Empty" ) {
            replyText.hidden = false
            replyButton.setTitle("Tweet", forState: UIControlState.Normal)
            replyText.text = "@" + userName.text!
        }
        else {
            TwitterClient.sharedInstance.reply(replyText.text!, statusId: tweet.tweetId!)
            replyText.text = "Empty"
            replyText.hidden = true
            replyButton.setTitle("Reply", forState: UIControlState.Normal)
        }
        
    }
    
    @IBAction func backButton(sender: AnyObject) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("navVC") as! UIViewController
            self.presentViewController(viewController, animated: true, completion: nil)
        })
    }
    
    
    @IBAction func retweetButtonClicked(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(tweet.tweetId!)

    }
    
    
    @IBAction func likeButtonClicked(sender: AnyObject) {
        TwitterClient.sharedInstance.favorite(tweet.tweetId!)

    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
