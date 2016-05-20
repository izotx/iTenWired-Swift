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
        let storyboard = UIStoryboard.init(name: "AgendaMain", bundle: nil)
        let destinationViewController = storyboard.instantiateViewControllerWithIdentifier("AgendaInitial")
        splitViewController?.showDetailViewController(destinationViewController, sender: nil)
    }
    @IBOutlet weak var ItinTable: UITableView!
    
    let myItenController = MyItenController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = editButtonItem()
        
        self.UIConfig()
        
        self.ItinTable.delegate = self
        self.ItinTable.dataSource = self
        self.ItinTable.userInteractionEnabled = true
    }
    
    internal func UIConfig(){
        self.ItinTable.backgroundColor = ItenWiredStyle.background.color.mainColor
        
        ItinTable.estimatedRowHeight = 85.0
        ItinTable.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItenController.getMyItenEvents().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! EventCell
        let event = myItenController.getMyItenEvents()[indexPath.row]
        
        cell.build(event)
        cell.userInteractionEnabled = true
        
        return cell

    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("Row Selected")
        let destinationViewController: EventViewController
            = (storyboard?.instantiateViewControllerWithIdentifier("EventViewController") as? EventViewController)!
        
        let event = myItenController.getMyItenEvents()[indexPath.row]
        destinationViewController.event = event
        
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        ItinTable.reloadData()
    }
    
    /*func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .Normal, title: "Remove from my Iten") { action, index in
            self.myItenController.deleteFromMyIten(self.myItenController.getMyItenEvents()[indexPath.row])
            tableView.reloadData()
        }
        delete.backgroundColor = UIColor.lightGrayColor()
        
        
        return [delete]
    }*/
    
    override func setEditing(editing: Bool, animated: Bool) {
       
        
        self.ItinTable.setEditing(!ItinTable.editing, animated: animated)
        if ItinTable.editing{
            self.navigationItem.rightBarButtonItem?.title = "Done"
        }
        else{
            self.navigationItem.rightBarButtonItem?.title = "Edit"
        }
    }
    
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete{
            self.myItenController.deleteFromMyIten(self.myItenController.getMyItenEvents()[indexPath.row])
            tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
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
