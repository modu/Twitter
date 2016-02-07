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
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        //let tweets = TwitterClient.sharedInstance.getHomeTimeLine()
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user :User? , error: NSError?) in
            if user != nil {
                self.tweets = TwitterClient.sharedInstance.getHomeTimeLine()
            }
            else {
                //Hanlde Login error
            }
        }
        
        //         Hide HUD once network request comes back (must be done on main UI thread)
        MBProgressHUD.hideHUDForView(self.view, animated: true)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath)
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
