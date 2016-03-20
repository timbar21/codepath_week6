//
//  Post.swift
//  week_6_instaparse
//
//  Created by Tim Barnard on 3/16/16.
//  Copyright © 2016 Tim Barnard. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    
    var photo: UIImage?
    var author: PFUser?
    var caption: String?
    var likesCount: Int?
    var commentsCount: Int?
    var name: String?
    var cell: HomeTableViewCell?
    
    init(postObject: PFObject) {
        
        super.init()
        
        let newPostObject = postObject
        
        caption = newPostObject["caption"] as? String
        author = newPostObject["author"] as! PFUser?
        likesCount = newPostObject["likesCount"] as? Int
        commentsCount = newPostObject["commentsCount"] as? Int
        name = newPostObject["name"] as? String
        
        
        if let newPhoto = postObject.valueForKey("media")! as? PFFile {
            
            newPhoto.getDataInBackgroundWithBlock({(imageData: NSData?, error: NSError?) -> Void in
                if (error == nil) {
                    let image = UIImage(data: imageData!)
                    
                    print(image)
                    self.photo = image
                    self.cell?.post = self
                    
                    print("")
                    print("UserPost photo is: \(self.photo)" )
                    print("UserPost image is: \(image)")
                    print("")
                    
                } else {
                    print("ERROR: could not get image \(error?.localizedDescription)")
                }
                }, progressBlock: { (int: Int32) -> Void in
            })
        }
    }
    
    /**
     Method to post user media to Parse by uploading image file
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let media = PFObject(className: "Post")
        
        print("Posting user image")
        // Add relevant fields to the object
        media["media"] = getPFFileFromImage(image) // PFFile column type
        media["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        media["caption"] = caption
        media["likesCount"] = 0
        media["commentsCount"] = 0
        
        
        // Save object (following function will save the object in Parse asynchronously)
        media.saveInBackgroundWithBlock(completion)
        print("user image save complete")
    }
    
    
    class func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    /**
     Method to post user media to Parse by uploading image file
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        print("nil")
        
        return nil
    }

}
