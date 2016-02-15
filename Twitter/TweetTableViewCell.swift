//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Varun Vyas on 06/02/16.
//  Copyright © 2016 Varun Vyas. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var realName: UILabel!
    
    @IBOutlet weak var UserName: UILabel!
    
    @IBOutlet weak var createdTime: UILabel!
    
    @IBOutlet weak var tweetText: UILabel!

    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var favoriteCountLabel: UILabel!
 
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favoritesButton: UIButton!
    
    var tweetIdSpec: String!

    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.tag = 2;
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func retweetAction(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(tweetIdSpec!)

    }
    
    @IBAction func favoritesAction(sender: AnyObject) {
        TwitterClient.sharedInstance.favorite(tweetIdSpec!)

    }

}
