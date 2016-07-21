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
//
//  LocationViewController.swift
//  Conference App
//
//  Created by Felipe N. Brito on 7/18/16.
//
//

import UIKit

class LocationViewController: UIViewController {
    
    /// loading activity indicator
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    /// main tableview
    @IBOutlet var tableView: UITableView!
    
    /// Location Object
    internal var location : Location!
    
    /// Location Controller
    var locationController = LocationController()
    
    /// Events list
    var events : [Event]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //TablewView delegate
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Load data
        events = locationController.getAllEvents(fromLocation: location)
        
        self.navigationItem.title = location.name
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.UIConfig()
    }
    
    
    internal func UIConfig(){
        tableView.backgroundColor = ItenWiredStyle.background.color.mainColor
        
        self.navigationController?.navigationBarHidden = false
        self.tableView.estimatedRowHeight = 85.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
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

//MARK: UITableViewDelegate, UITableViewDataSource
extension LocationViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return events.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if events.count > 0{
            return 1
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! EventCell
        let event = events[indexPath.row]
        
        //builds cell data
        cell.build(event)
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("dateCell") as? AgendaHeaderTableViewCell
        
        if events.count == 0{
            cell?.dateLabel.text = ""
            return cell
        }
        
        
        let date = events[0].date
        
        let month = Int(date.componentsSeparatedByString("/")[0])
        let year = date.componentsSeparatedByString("/")[2]
        
        let monthString = DateEnum.getMonth(month!)
        
        cell?.dateLabel.text = "\(monthString) \(year)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let storyboard = UIStoryboard.init(name: "AgendaMain", bundle: nil)
        
        let destinationViewController: EventViewController
            = (storyboard.instantiateViewControllerWithIdentifier("EventViewController") as? EventViewController)!
        
        let event = events[indexPath.row]
        destinationViewController.event = event
        
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
}

extension LocationViewController : iBeaconNearMeViewControllerProtocol {
    
    func build(with nearMeItem: iBeaconNearMeProtocol){
    
        if let location = nearMeItem as? Location{
           self.location = location
        }        
    }

}