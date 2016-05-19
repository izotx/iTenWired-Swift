//
//  ViewController.swift
//  Agenda1
//
//  Created by Felipe Neves Brito on 4/5/16.
//  Copyright © 2016 Felipe Neves Brito. All rights reserved.
//

import UIKit

class AgendaViewController: UITableViewController, UIGestureRecognizerDelegate {

    var agendaController:AgendaController = AgendaController()

    let myItenController = MyItenController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.UIConfig()
        
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableViewAutomaticDimension     // Sets the table view's row height to automatic
    }
    
    internal func UIConfig(){
        tableView.backgroundColor = ItenWiredStyle.background.color.mainColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if(section == 0){
            return agendaController.getEventsCount()
        }
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! EventCell
        let event = agendaController.getEventAt(indexPath.row)
        
        //builds cell data
        cell.build(event)
        cell.setStartButton(myItenController.isPresent(event))
        
        return cell
    }
 
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            let destinationViewController: EventViewController
            = (storyboard?.instantiateViewControllerWithIdentifier("EventViewController") as? EventViewController)!
            
            let event = self.agendaController.getEventAt(indexPath.row)
            destinationViewController.event = event
            
            self.navigationController?.pushViewController(destinationViewController, animated: true)
       
    }
    
    // Displays the Menu when clicked
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

