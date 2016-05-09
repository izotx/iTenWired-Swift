//
//  AttendeesViewController.swift
//  Conference App
//
//  Created by tuong on 4/11/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit

class AttendeesViewController: UITableViewController, UISearchResultsUpdating {
    
    var AttendeeControl:AttendeeController = AttendeeController()
    var detailViewController: DetailViewController? = nil
    var attendes = [Event]()
    var filtered = [Event]()
    var Handles = [String]()
    var Filtered = [String]()
    let searchController = UISearchController(searchResultsController: nil)
    //let searchController = UISearchController(searchResultsController: nil)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ATT = AttendeeControl.dataLoader.getAttendee()
        let attendes = ATT.event
        for i in 0...attendes.count-1{
            //print("A")
            if (!test(Handles, object: attendes[i].name)){
                Handles.append(attendes[i].name)
            }
        }
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        // Setup the Search Controller
        //searchController.searchResultsUpdater = self
        //searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["All", "sponsors", "exhitbitors", "speakers"]
        tableView.tableHeaderView = searchController.searchBar
        print(AttendeeControl.attendee.event)
        for i in 0...AttendeeControl.attendee.event.count-1{
            //print("B")
            print(AttendeeControl.attendee.event[i].name)
            print(AttendeeControl.attendee.event[i].logo)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        // Sets the table view's row height to automatic
        self.tableView.reloadData()
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
        /*if(section == 0){
         return AttendeeControl.getEventsCount()
         }
         
         return attendes.count*/
        
        if (searchController.active){
            //print("C")
            /*if (searchController.searchBar.text?.isEmpty) != nil{
             return Handles.count
             }*/
            //if searchController.searchBar.text? == nil{
            //  return Handles.count
            //}
            
            if let q = searchController.searchBar.text{
                //print("D")
                if q.characters.count <= 0{
                    return Handles.count
                }
                return Filtered.count
            }
            
        }
        return Handles.count
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! AttendeesCell
        let event = AttendeeControl.getEventAt(indexPath.row)
        
        
        
        
        
        
        
        
        
        
        
        if searchController.active{
            if let q = searchController.searchBar.text{
                
                if q.isEmpty{
                    cell.setName(AttendeeControl.attendee.event[indexPath.row].name)
                    cell.setjobTitle(AttendeeControl.attendee.event[indexPath.row].jobTitle)
                    
                    
                    
                    
                    if (hasLogo(AttendeeControl.attendee.event, curDat: Handles, curItm: Handles[indexPath.row])){
                        print("INN")
                        cell.setLogo(AttendeeControl.attendee.event[indexPath.row].logo)
                    } else {
                        print("OUT")
                        cell.logoImage.image = UIImage(named: "blank-image")
                    }
                }
                else{
                    cell.setName(Filtered[indexPath.row])
                    for i in 0...Handles.count-1{
                        if Filtered[indexPath.row] == Handles[i]{
                            print("\(Filtered[indexPath.row]) \(hasLogo(AttendeeControl.attendee.event, curDat: Handles, curItm: Handles[i]))")
                            cell.setjobTitle(AttendeeControl.getEventAt(i).jobTitle)
                            
                            
                            //hasLogo event | curDat: Filtered | curItm
                            
                            if (hasLogo(AttendeeControl.attendee.event, curDat: Handles, curItm: Handles[i])){
                                print("INN")
                                print(AttendeeControl.getEventAt(i).logo)
                                //cell.setLogo(AttendeeControl.getEventAt(i).logo)
                                
                            
                                
                                
                                cell.setLogo(AttendeeControl.attendee.event[getIndex(AttendeeControl.attendee.event, object: AttendeeControl.attendee.event[getIndex(Handles, object: Filtered[indexPath.row])])].logo)
                            }
                            else {
                                print("OUT")
                                cell.logoImage.image = UIImage(named: "blank-image")
                            }
                        }
                    }
                }
            }
            else {
                cell.setName(event.name)
                cell.setjobTitle(event.jobTitle)
                if (hasLogo(AttendeeControl.attendee.event, curDat: Handles, curItm: Handles[indexPath.row])){
                    print("INN")
                    cell.setLogo(AttendeeControl.attendee.event[indexPath.row].logo)
                }
                else {
                    print("OUT")
                    cell.logoImage.image = UIImage(named: "blank-image")
                }
            }
        }
        else{
            cell.setName(event.name)
            cell.setjobTitle(event.jobTitle)
            if (hasLogo(AttendeeControl.attendee.event, curDat: Handles, curItm: Handles[indexPath.row])){
                print("INN")
                cell.setLogo(AttendeeControl.attendee.event[indexPath.row].logo)
            }
            else {
                print("OUT")
                cell.logoImage.image = UIImage(named: "blank-image")
            }
        }
        //super.tableView.reloadData()
        
        return cell
    }
    
    //filtering content
    /*func filterContentForSearchText(searchText: String, scope: String = "All") {
     filtered = attendes.filter({( event : Event) -> Bool in
     let categoryMatch = (scope == "All") || (event.name == scope)
     return categoryMatch && event.name.lowercaseString.containsString(searchText.lowercaseString)
     })
     tableView.reloadData()
     }*/
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let event: Event
                
                if searchController.active && searchController.searchBar.text != "" {
                    event = filtered[indexPath.row]
                    //print("S")
                } else {
                    event = attendes[indexPath.row]
                    //print("T")
                }
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! AttendeeDescription
                controller.detailEvent = event
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (Handles as NSArray).filteredArrayUsingPredicate(searchPredicate)
        Filtered = array as! [String]
        //let arr = (attendes as NSArray).filteredArrayUsingPredicate(searchPredicate)
        //filtered = array as! [Event]
        
        self.tableView.reloadData()
    }
    func test(table: [AnyObject], object: AnyObject) -> Bool{
        if table.count>0{
            for i in 0...table.count-1{
                //print("U")
                if table[i].isEqual(object){
                    //print("V")
                    return true
                }
            }
        }
        return false
    }
    func getIndex(table: [AnyObject], object: AnyObject) -> Int{
        if table.count>0{
            for i in 0...table.count-1{
                //print("U")
                if table[i].isEqual(object){
                    //print("V")
                    return i
                }
            }
        }
        return -1
        
    }
    func hasLogo(evt: [Event], curDat: [AnyObject], curItm: AnyObject)-> Bool{
        //Goal: Use curDat and curItm to determine item in evt.
        //      If evt[curItm].isEmpty return false
        
        
        
        for i in 0...evt.count/2-1{
            if evt[i].logo.startIndex != evt[i].logo.endIndex{
                if test(curDat, object: curItm){
                    let ga = getIndex(curDat, object: curItm)
                    if i == ga{
                        if !evt[i].logo.isEmpty{
                            return true
                        }
                    }
                }
            }
            
        }
        return false
    }
}



/*extension AttendeesViewController: UISearchBarDelegate {
 // MARK: - UISearchBar Delegate
 func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
 filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
 }
 }*/

/*extension AttendeesViewController: UISearchResultsUpdating {
 // MARK: - UISearchResultsUpdating Delegate
 func updateSearchResultsForSearchController(searchController: UISearchController) {
 let searchBar = searchController.searchBar
 let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
 filterContentForSearchText(searchController.searchBar.text!, scope: scope)
 }
 
 }*/



