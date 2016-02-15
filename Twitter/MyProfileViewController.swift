//
//  MyProfileViewController.swift
//  Twitter
//
//  Created by Varun Vyas on 14/02/16.
//  Copyright © 2016 Varun Vyas. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    
    @IBOutlet weak var realName: UILabel!
    
    
    
    @IBOutlet weak var userName: UILabel!
    
    
    @IBOutlet weak var tweetCount: UILabel!
    
    @IBOutlet weak var followingCount: UILabel!
    
    
    @IBOutlet weak var followerCount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        realName.text = User.currentUser?.name
        userName.text = "@" + (User.currentUser?.screenName!)!
        
        profileImageView.setImageWithURL(NSURL(string: (User.currentUser?.profileImageURL!)!)!)
        tweetCount.text = String(User.currentUser!.dictionary["statuses_count"]!)
        followerCount.text = String(User.currentUser!.dictionary["friends_count"]!)
        followerCount.text = String(User.currentUser!.dictionary["followers_count"]!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
