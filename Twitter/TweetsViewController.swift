//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Varun Vyas on 06/02/16.
//  Copyright © 2016 Varun Vyas. All rights reserved.
//

import UIKit
import MBProgressHUD

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets :[Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 120.0
        tableView.rowHeight = UITableViewAutomaticDimension

        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        TwitterClient.sharedInstance.homeTimeline(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }
        //         Hide HUD once network request comes back (must be done on main UI thread)
        MBProgressHUD.hideHUDForView(self.view, animated: true)
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)

        
        // Do any additional setup after loading the view.
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        // Make network request to fetch latest data
        TwitterClient.sharedInstance.homeTimeline(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }
        MBProgressHUD.hideHUDForView(self.view, animated: true)

        // Do the following when the network request comes back successfully:
        // Update tableView data source
        refreshControl.endRefreshing()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return (tweets?.count)!
        }
        return 0    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetTableViewCell
        let tweet = tweets![indexPath.row]
        cell.realName.text = tweet.user!.name
        cell.UserName.text = "@" + tweet.user!.screenName!
        cell.profileImage.setImageWithURL(NSURL(string: tweet.user!.profileImageURL!)!)
        cell.tweetText.text = tweet.text
        cell.favoriteCountLabel.text = String(tweet.favCount!)
        cell.retweetCountLabel.text = String(tweet.retweetCount!)
        cell.tweetIdSpec = tweet.tweetId

//        cell.favCtLabel.text = String(tweet.favCount!)
//        cell.retweetCtLabel.text = String(tweet.retweetCount!)
//        cell.tweetIdSpec = tweet.tweetId
        let elapsedTime = NSDate().timeIntervalSinceDate(tweet.createdAt!)
        let duration = Int(elapsedTime)
        var finalTime = "0"
        
        if duration / (360 * 24) >= 1 {
            finalTime = String(duration / (360 * 24)) + "d"
        }
        else if duration / 360 >= 1 {
            finalTime = String(duration / 360) + "h"
            
        }
        else if duration / 60 >= 1 {
            finalTime = String(duration / 60) + "min"
        }
        else {
            finalTime = String(duration) + "s"
        }
        
        cell.createdTime.text = String(finalTime)

        return cell
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
