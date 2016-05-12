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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
       return atendeeControler.getTotalAtendeeCount() + 3
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
                
                if(index == 0){
                    let cell = tableView.dequeueReusableCellWithIdentifier("sponsersHeaderCell", forIndexPath: indexPath)
                    return cell
                }
                
                let cell = tableView.dequeueReusableCellWithIdentifier("sponsersCell", forIndexPath: indexPath) as! AttendeesCell
                let sponser = atendeeControler.getSponserAtIndex(index - 1)
                cell.build(sponser)
                
                return cell
            }
            
            index -= atendeeControler.getSponsersCount() + 1
        
            if(index >= 0 && index - 1 < atendeeControler.getExibitorsCount()) {
            
                if(index == 0){
                    let cell = tableView.dequeueReusableCellWithIdentifier("exibitorsHeaderCell", forIndexPath: indexPath)
                    return cell
                }
                
                let cell = tableView.dequeueReusableCellWithIdentifier("exibitorsCell", forIndexPath: indexPath) as! AttendeesCell
                let  exibitor = atendeeControler.getExibitorAtIndex(index - 1)
                cell.build(exibitor)
                
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
            
            return cell
        }
 
        return tableView.dequeueReusableCellWithIdentifier("exibitorsCell", forIndexPath: indexPath) as! AttendeesCell
    }
    
    @IBAction func showMenu(sender: AnyObject) {
        let rightNavController = splitViewController!.viewControllers.last as! UINavigationController
        
        rightNavController.popToRootViewControllerAnimated(true)
    }
    
}



