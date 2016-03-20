//
//  CameraViewController.swift
//  week_6_instaparse
//
//  Created by Tim Barnard on 3/16/16.
//  Copyright © 2016 Tim Barnard. All rights reserved.
//

import UIKit
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var captionView: UITextView!
    @IBOutlet weak var capturedImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var photoLibraryButton: UIButton!
    
    let vc = UIImagePickerController()
    var image: UIImage!
    
    override func viewDidLoad() {
//        super.viewDidLoad()
        
        captionView.delegate = self
        captionView.text = "Enter caption..."
        captionView.textColor = UIColor.lightGrayColor()
        
        vc.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let image = info[UIImagePickerControllerEditedImage] as! UIImage
            
            // Do something with the images (based on your use case)
            capturedImageView.image = image
            
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onCameraButton(sender: AnyObject) {
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.Camera
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func onSubmitButton(sender: AnyObject) {
        let newImage = Post.resize(image, newSize: CGSize(width: 300, height: 500))
        Post.postUserImage(newImage, withCaption: captionView.text) { (success: Bool, error: NSError?) -> Void in
            if success {
                self.capturedImageView.image = nil
                self.captionView.text = nil
                self.tabBarController?.selectedIndex = 0
            } else {
                print("error in submit")
            }
        }
    }
    
    @IBAction func onPhotoLibraryButton(sender: AnyObject) {
//        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    func textViewDidBeginEditing(textView: UITextView) {
        if captionView.textColor == UIColor.lightGrayColor() {
            captionView.text = nil
            captionView.textColor = UIColor.blackColor()
        }
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