//    Copyright (c) 2016, UWF
//    All rights reserved.
//
//    Redistribution and use in source and binary forms, with or without
//    modification, are permitted provided that the following conditions are met:
//
//    * Redistributions of source code must retain the above copyright notice,
//    this list of conditions and the following disclaimer.
//    * Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
//    * Neither the name of UWF nor the names of its contributors may be used to
//    endorse or promote products derived from this software without specific
//    prior written permission.
//
//    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//    ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
//    LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//    CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//    SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//    INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//    CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//    ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//    POSSIBILITY OF SUCH DAMAGE.

//  Created by Felipe Neves Brito on 12/5/16.

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
        
        if pendingOperarions.downloadsInProgress[indexPath.row] != nil{
            return
        }
        
        let downloader = ImageDownloader(photoRecord: photoDetails)
        
        downloader.completionBlock = {
            
            if downloader.cancelled {
                return
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.pendingOperarions.downloadsInProgress.removeValueForKey(indexPath.row)
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            })
        }
        
        pendingOperarions.downloadsInProgress.removeValueForKey(indexPath.row)
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
}