//
//  TableViewCell.swift
//  week_6_instaparse
//
//  Created by Tim Barnard on 3/16/16.
//  Copyright © 2016 Tim Barnard. All rights reserved.
//

import UIKit
import Parse

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    let captionCheck  = "Enter caption..."
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var postsObject: PFObject? {
        didSet {
            post = Post(postObject: postsObject!)
            post.cell = self;
        }
    }
    
    var post: Post! {
        didSet {
            userImageView.image = post.photo
            print("This is the image that is to be set: \(post.photo)")
            // this causes the nil crash!! so userPost.photo must be nil...
            //            print("This is the image thatx is to be set: \((post.photo)!)")
            
            
            if post.caption == captionCheck {
                captionLabel.text = ""
            } else {
                captionLabel.text = post.caption
            }
            print("the caption is: \((captionLabel.text)!)")
            
            usernameLabel.text = post.author?.username
            print("the user is: \((usernameLabel.text)!)")
            print("")
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
