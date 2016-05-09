//
//  IteneraryViewController.swift
//  Conference App
//
//  Created by Greg Gruse on 4/9/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit

class ItineraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    
    @IBAction func AgendaBTN(sender: AnyObject) {
        self.showViewController(Vc[1], sender: self)
    }
    @IBOutlet weak var ItinTable: UITableView!
    var dataMyIten: appendToMyIten = appendToMyIten()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ItinTable.delegate = self
        self.ItinTable.dataSource = self
        
        
        ItinTable.estimatedRowHeight = 85.0
        ItinTable.rowHeight = UITableViewAutomaticDimension
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        dataMyIten.reloadData()
        ItinTable.reloadData()
    }
    //s
    @IBAction func Clear(sender: AnyObject) {
        var appData = AppData()
        appData.clearItin()
        dataMyIten.reloadData()
        ItinTable.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataMyIten.events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! EventCell
        let event = dataMyIten.events[indexPath.row]
        
        cell.setName(event.name)
        cell.setStartTime(event.timeStart)
        cell.setStopTime(event.timeStop)
        cell.setDate(event.date)
        
        return cell

    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let destinationViewController: EventViewController
            = (storyboard?.instantiateViewControllerWithIdentifier("EventViewController") as? EventViewController)!
        
        let event = dataMyIten.events[indexPath.row]
        destinationViewController.event = event
        
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        ItinTable.reloadData()
    }
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        
        
        let add = UITableViewRowAction(style: .Normal, title: "Remove from my Iten") { action, index in
            self.dataMyIten.removeData(self.dataMyIten.events[indexPath.row].id)
            self.dataMyIten.reloadData()
            self.ItinTable.reloadData()
            print("Selected")
            print(indexPath.row)
            
        }
        add.backgroundColor = UIColor.lightGrayColor()
        
        
        return [add]
    }
    
}
