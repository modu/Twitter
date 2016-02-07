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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
