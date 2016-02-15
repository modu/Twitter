//
//  NewTweetViewController.swift
//  Twitter
//
//  Created by Varun Vyas on 09/02/16.
//  Copyright © 2016 Varun Vyas. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController {
    var window: UIWindow?
    
    @IBOutlet weak var tweetTextField: UITextView!
    
    @IBOutlet var cancelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTweetClicked(sender: AnyObject) {
        
        TwitterClient.sharedInstance.makeTweet(tweetTextField.text!)
        tweetTextField.text = ""
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("navVC") as! UIViewController
            self.presentViewController(viewController, animated: true, completion: nil)
        })
        
    }
    
    @IBAction func onClickCancel(sender: AnyObject) {
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)  /*Storyboards are just xml and they can be refered like this?*/
        //
        //        let vc = storyboard.instantiateViewControllerWithIdentifier("navVC") as UIViewController
        //
        //        window?.rootViewController = vc
        
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
