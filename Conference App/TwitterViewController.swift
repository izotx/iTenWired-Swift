//
//  ViewController.swift
//  Agenda1
//
//  Created by Felipe Neves Brito on 12/5/16.
//  Copyright © 2016 Felipe Neves Brito. All rights reserved.
//

import UIKit

class TwitterViewController: UITableViewController{

    let twitterController = TwitterController()
    var tweets : [Twitter] = []
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tweets = twitterController.getTweets()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("twitterCell", forIndexPath: indexPath) as? TwitterCell
        
        cell?.build(tweets[indexPath.row])
        return cell!
    }
}