//
//  ViewController.swift
//  Twitter
//
//  Created by Varun Vyas on 02/02/16.
//  Copyright © 2016 Varun Vyas. All rights reserved.
//
import UIKit
import AFNetworking
import BDBOAuth1Manager

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLogin(sender: AnyObject) {
        
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                print("user !=nil in view controller ")
                
                self.performSegueWithIdentifier("loginSegue", sender: self)
                
            } else {
                // handle login error
            }
        }
    }
}


