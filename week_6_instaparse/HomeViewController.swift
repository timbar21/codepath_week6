//
//  HomeViewController.swift
//  week_6_instaparse
//
//  Created by Tim Barnard on 3/15/16.
//  Copyright © 2016 Tim Barnard. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var userPosts: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let userPosts = userPosts {
            return userPosts.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCellWithIdentifier("HomeTableViewCell", forIndexPath: indexPath) as! HomeTableViewCell
        cell.selectionStyle = .None
        
        if (userPosts != nil) {
            let userPost = userPosts![indexPath.row]
            cell.postsObject = userPost
        }
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        getPosts()
        self.tableView.reloadData()
    }
    
    func getPosts() {
        // construct PFQuery and get data from Parse
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                
                self.userPosts = posts
                self.tableView.reloadData()
            } else {
                print("ERROR: unable to get photos from parse")
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
}