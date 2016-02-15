//
//  profileViewController.swift
//  Twitter
//
//  Created by Varun Vyas on 09/02/16.
//  Copyright © 2016 Varun Vyas. All rights reserved.
//

import UIKit

class profileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var realName: UILabel!
    
    @IBOutlet weak var tweetCount: UILabel!
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var followingCount: UILabel!
    
    @IBOutlet weak var followingLabel: UILabel!
    
    @IBOutlet weak var followerCount: UILabel!
    
    @IBOutlet weak var followerLabel: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    
    
    
    @IBOutlet weak var backButton: UIButton!
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
      
        realName.text = user!.name!
        userName.text = "@" + user!.screenName!
        tweetCount.text = String(user!.dictionary["statuses_count"]!)
        followingCount.text = String(user!.dictionary["friends_count"]!)
        followerCount.text = String(user!.dictionary["followers_count"]!)
        profileImage.setImageWithURL(NSURL(string: user!.profileImageURL!)!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onClickedBackButton(sender: AnyObject) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("navVC") as! UIViewController
            self.presentViewController(viewController, animated: true, completion: nil)
        })
        
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
