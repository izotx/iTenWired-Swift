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
    
    var photos = [Photorecord]()
    let pendingOperarions = PendingOperarions()
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        self.fetchTweets()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("twitterCell", forIndexPath: indexPath) as? TwitterCell
        
        if cell?.accessoryView == nil {
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
            cell?.accessoryView = indicator
        }
        let indicator = cell?.accessoryView as! UIActivityIndicatorView
        
        let photoDetails = photos[indexPath.row]
        
        switch (photoDetails.state){
        case PhotoRecordState.Filtered, PhotoRecordState.Downloaded:
            indicator.stopAnimating()
        case PhotoRecordState.Failed:
            indicator.stopAnimating()
            //TODO:
        case PhotoRecordState.New:
            indicator.startAnimating()
            self.startOperationForPhotoRecord(photoDetails, indexPath: indexPath)
        }
        
        cell?.build(tweets[indexPath.row])
        cell?.setProfileImage(photoDetails)
        
        return cell!
    }
    
    func startOperationForPhotoRecord(photoDetails: Photorecord, indexPath: NSIndexPath){
    
        switch (photoDetails.state) {
        case PhotoRecordState.New:
            startDownloadForRecord(photoDetails, indexPath: indexPath)
            break
            
        default: print("Do Nothing..")
        }
        
    }
    
    func startDownloadForRecord(photoDetails: Photorecord, indexPath: NSIndexPath){
        
        if let downloadoperarion = pendingOperarions.downloadsInProgress[indexPath]{
            return
        }
        
        let downloader = ImageDownloader(photoRecord: photoDetails)
        
        downloader.completionBlock = {
        
            if downloader.cancelled {
                return
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.pendingOperarions.downloadsInProgress.removeValueForKey(indexPath)
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            })
        }
        
        pendingOperarions.downloadsInProgress.removeValueForKey(indexPath)
        pendingOperarions.downloadQueue.addOperation(downloader)
    }
    
    func fetchTweets(){
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        self.tweets = twitterController.getTweets()
        
        for tweet in self.tweets {
            let url = NSURL(string: tweet.user.profileImage)
            let photoRecord = Photorecord(name: tweet.user.profileImage, url: url!)
            self.photos.append(photoRecord)
        }
        self.tableView.reloadData()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func checkForNewTweets() -> Bool{
        //TODO:
        return self.twitterController.getTweets().count != self.tweets.count
    }
    
    
    @IBAction func showMenu(sender: AnyObject) {
    
        if let splitController = self.splitViewController{
    
            if !splitController.collapsed {
                splitController.toggleMasterView()
    
            } else{
                let rightNavController = splitViewController!.viewControllers.first as! UINavigationController
                rightNavController.popToRootViewControllerAnimated(true)
            }
        }
    }
    
    
    
}