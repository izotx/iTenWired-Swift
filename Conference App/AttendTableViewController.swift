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
//

//  AttendeesViewController.swift
//  Conference App
//  Created by tuong on 4/11/16.

import UIKit

class AttendeesViewController: UITableViewController{
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let atendeeControler = AttendeeController()
    
    var sponsers:[Sponser] = []
    var exhibitors:[Exibitor] = []
    var speakers:[Speaker] = []
    
    // Photo Loader and controller for exhibitor photos
    var exhibitorPhotos = [Photorecord]()
    let exibitorPendingOperations = PendingOperarions()
    
    
    // Photo loader and controller for sponsers
    var sponserPhotos = [Photorecord]()
    let sponserPendingoperations = PendingOperarions()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Starts the activity indicator. Runs until data is loading
        self.activityIndicator.startAnimating()
        
        
        // Async data load
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            //Gets attendees Data
            self.loadSponsers()
            self.loadExhibitors()
            self.speakers = self.atendeeControler.getSpeakers()
            
            // Deactivates Activity indicator
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidden = true
            
            //Relaods TableView Data
            self.tableView.reloadData()
        }
    }
    
    internal func UIConfig(){
        self.tableView.backgroundColor = ItenWiredStyle.background.color.invertedColor
        self.view.backgroundColor = ItenWiredStyle.background.color.invertedColor
    }
    
    // Loads sponser data and populates the photorecord array
    internal func loadSponsers(){
        let sponsers = self.atendeeControler.getSponsers()
        
        for sponser in sponsers {
            self.sponsers.append(sponser)
            let url = NSURL(string: sponser.logo)
            let photoRecord = Photorecord(name: sponser.logo, url: url!)
            self.sponserPhotos.append(photoRecord)
        }
    }
    
    // Loads exhibitor data and populates the photorecord array
    internal func loadExhibitors(){
        let exhibitors = self.atendeeControler.getExibitors()
        
        for exhibitor in exhibitors {
            self.exhibitors.append(exhibitor)
            let url = NSURL(string: exhibitor.logo)
            let photoRecord = Photorecord(name: exhibitor.logo, url: url!)
            self.exhibitorPhotos.append(photoRecord)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var index = indexPath.row
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        
        // Sponser Cell
        if index >= 0 && index <= sponsers.count{
            if index == 0 { //excludes header
                return
            }
            
            let storyboard = UIStoryboard.init(name: "Attendees", bundle: nil)
            let destinationViewController = storyboard.instantiateViewControllerWithIdentifier("SponserDescriptionViewController") as? SponserUIViewController
            
            destinationViewController?.sponser = sponsers[index - 1]
            
            self.navigationController?.pushViewController(destinationViewController!, animated: true)
            
        }
        
        index = index - (sponsers.count + 1)
        
        if index >= 0 && index <= exhibitors.count{
            if index == 0{  // Excludes Header
                return
            }
            
            let storyboard = UIStoryboard.init(name: "Attendees", bundle: nil)
            let destinationViewController = storyboard.instantiateViewControllerWithIdentifier("SponserDescriptionViewController") as? SponserUIViewController
            
            destinationViewController?.exhibitor = exhibitors[index - 1]
            self.navigationController?.pushViewController(destinationViewController!, animated: true)
        }
        
        index = index - (exhibitors.count + 1)
        
        // Speaker
        if index >= 0 && index <= speakers.count {
            
            if index == 0{
                return
            }
            let storyboard = UIStoryboard.init(name: "Attendees", bundle: nil)
            
            let destinationViewController = storyboard.instantiateViewControllerWithIdentifier("SpeakerDescriptionViewController") as? SpeakerDescriptionViewController
            
            
            destinationViewController?.speaker = speakers[index-1]
            
            self.navigationController?.pushViewController(destinationViewController!, animated: true)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.exhibitors.count + self.sponsers.count + self.speakers.count
    }
    
    
    //FIXME: IMPLEMENT
    func searchPerformed() -> Bool{
        return false
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var index = indexPath.row
        
        //TODO: search must be implemented
        if searchPerformed() {
        
            
        } else {
        
            //Sponsers
            if(index >= 0 && index - 1 < atendeeControler.getSponsersCount()){
                
                if(index == 0){ // If Sponser Header
                    let cell = tableView.dequeueReusableCellWithIdentifier("sponsersHeaderCell", forIndexPath: indexPath)
                    return cell
                }
                
                let photoDetails = sponserPhotos[index-1]
                
                
                let cell = tableView.dequeueReusableCellWithIdentifier("exibitorsCell", forIndexPath: indexPath) as! AttendeesCell
                
                if photoDetails.state == PhotoRecordState.New {
                    self.startDownloadForRecord(photoDetails, indexPath: indexPath, pendingOperations: self.sponserPendingoperations)
                }
                
                let sponser = self.sponsers[index-1]
                
                cell.build(sponser)
                cell.setProfileImage(photoDetails)
                
                return cell
            }
            
            index -= atendeeControler.getSponsersCount() + 1 // Recalculates the index for exhibitors
        
            // Exhibitors
            if(index >= 0 && index - 1 < atendeeControler.getExibitorsCount()) {
            
                if(index == 0){
                    let cell = tableView.dequeueReusableCellWithIdentifier("exibitorsHeaderCell", forIndexPath: indexPath)
                    return cell
                }
                
                let photoDetails = self.exhibitorPhotos[index-1]
                
                let cell = tableView.dequeueReusableCellWithIdentifier("exibitorsCell", forIndexPath: indexPath) as! AttendeesCell
                
                if photoDetails.state == PhotoRecordState.New {
                    self.startDownloadForRecord(photoDetails, indexPath: indexPath, pendingOperations: self.exibitorPendingOperations)
                }
                
                let  exibitor = self.exhibitors[index-1]
                cell.build(exibitor)
                cell.setProfileImage(photoDetails)
    
                return cell
            }
        }
        
        index -= atendeeControler.getExibitorsCount() + 1
        
        if(index >= 0 && index - 1 < atendeeControler.getSpeakersCount()){
            if(index == 0){
                let cell = tableView.dequeueReusableCellWithIdentifier("speakersHeaderCell", forIndexPath: indexPath)
                return cell
            }
            
            let cell = tableView.dequeueReusableCellWithIdentifier("speakerCell", forIndexPath: indexPath) as! SpeakerCell
            let  speaker = atendeeControler.getSpeackerAtIndex(index - 1)
            cell.build(speaker)
            cell.imageView?.image = nil
        }
 
        return tableView.dequeueReusableCellWithIdentifier("exibitorsCell", forIndexPath: indexPath) as! AttendeesCell
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
    
    func startOperationForPhotoRecord(photoDetails: Photorecord, indexPath: NSIndexPath, pendingOperations: PendingOperarions){
        
        switch (photoDetails.state) {
        case PhotoRecordState.New:
            if NetworkConnection.isConnected(){
                startDownloadForRecord(photoDetails, indexPath: indexPath, pendingOperations: pendingOperations)
            }
            break
            
        default: print("Do Nothing..")
        }
        
    }
    
    func startDownloadForRecord(photoDetails: Photorecord, indexPath: NSIndexPath, pendingOperations: PendingOperarions){
        
        if pendingOperations.downloadsInProgress[indexPath.row] != nil{
            return
        }
        
        let downloader = ImageDownloader(photoRecord: photoDetails)
        
        downloader.completionBlock = {
            
            if downloader.cancelled {
                return
            }
            dispatch_async(dispatch_get_main_queue(), {
                pendingOperations.downloadsInProgress.removeValueForKey(indexPath.row)
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            })
        }
        
        pendingOperations.downloadsInProgress.removeValueForKey(indexPath.row)
        pendingOperations.downloadQueue.addOperation(downloader)
    }
}

