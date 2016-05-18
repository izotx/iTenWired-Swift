//
//  AttendeesViewController.swift
//  Conference App
//
//  Created by tuong on 4/11/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit

class AttendeesViewController: UITableViewController{
    
    
    let atendeeControler = AttendeeController()
    
    // Photo Loader and controller for exhibitor photos
    var exhibitorPhotos = [Photorecord]()
    let exibitorPendingOperations = PendingOperarions()
    var exhibitors:[Exibitor] = []
    
    // Photo loader and controller for sponsers
    var sponserPhotos = [Photorecord]()
    let sponserPendingoperations = PendingOperarions()
    var sponsers:[Sponser] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchExhibitors()  // Loads Exhibitors Data
        self.fetchSponsers()    // Loads Sponsers Data
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.exhibitors.count + self.sponsers.count + atendeeControler.getSpeakers().count
    }
    
    
    //FIXME: IMPLEMENT
    // returns true is the searchController is active and there is a search typed
    func searchPerformed() -> Bool{
        //if searchController.active {
           // if let query = searchController.searchBar.text {
            //    return true
            //}
      //  }
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
                
                switch photoDetails.state {
                    
                case PhotoRecordState.Downloaded:
                    break
                    
                case PhotoRecordState.New:
                    self.startDownloadForRecord(photoDetails, index: index-1, pendingOperations: self.sponserPendingoperations)
                    break
                    
                default:
                    break
                }
                
                let cell = tableView.dequeueReusableCellWithIdentifier("exibitorsCell", forIndexPath: indexPath) as! AttendeesCell
                let sponser = atendeeControler.getSponserAtIndex(index - 1)
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
                
                let photoDetails = exhibitorPhotos[index-1]
                
                switch photoDetails.state {
                case PhotoRecordState.Downloaded:
                    break
                case PhotoRecordState.New:
                    self.startOperationForPhotoRecord(photoDetails, index: index-1, pendingOperations: self.exibitorPendingOperations)
                    
                default: break
                }
                
                let cell = tableView.dequeueReusableCellWithIdentifier("exibitorsCell", forIndexPath: indexPath) as! AttendeesCell
                let  exibitor = atendeeControler.getExibitorAtIndex(index - 1)
                
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
        }
 
        return tableView.dequeueReusableCellWithIdentifier("exibitorsCell", forIndexPath: indexPath) as! AttendeesCell
    }
    
    func startOperationForPhotoRecord(photoDetails: Photorecord, index: Int, pendingOperations: PendingOperarions){
        
        switch (photoDetails.state) {

        case PhotoRecordState.New:pendingOperations
            startDownloadForRecord(photoDetails, index: index, pendingOperations: pendingOperations)
            break
            
        default: print("Do Nothing..")
        }
        
    }
    
    func startDownloadForRecord(photoDetails: Photorecord, index: Int, pendingOperations: PendingOperarions){
        
        if let downloadoperarion = pendingOperations.downloadsInProgress[index]{
            return
        }
        
        let downloader = ImageDownloader(photoRecord: photoDetails)
        
        downloader.completionBlock = {
            
            if downloader.cancelled {
                return
            }
            dispatch_async(dispatch_get_main_queue(), {
                pendingOperations.downloadsInProgress.removeValueForKey(index)
            })
        }
        
        pendingOperations.downloadsInProgress.removeValueForKey(index)
        pendingOperations.downloadQueue.addOperation(downloader)
    }
    
    @IBAction func showMenu(sender: AnyObject) {
        let rightNavController = splitViewController!.viewControllers.last as! UINavigationController
        
        rightNavController.popToRootViewControllerAnimated(true)
    }
    
    func fetchExhibitors(){
         let exhibitors = atendeeControler.getExibitors()
        
        for exhibitor in exhibitors {
            self.exhibitors.append(exhibitor)
            let url = NSURL(string: exhibitor.logo)
            let photoRecord = Photorecord(name: exhibitor.logo, url: url!)
            self.exhibitorPhotos.append(photoRecord)
            
        }
    }
    
    func fetchSponsers(){
        let sponsers = atendeeControler.getSponsers()
        
        for sponser in sponsers {
            self.sponsers.append(sponser)
            let url = NSURL(string: sponser.logo)
            let photoRecord = Photorecord(name: sponser.logo, url: url!)
            self.sponserPhotos.append(photoRecord)
        }
    }
    
}



