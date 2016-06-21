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

//  IteneraryViewController.swift
//  Conference App
//
//  Created by Greg Gruse on 4/9/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit

class ItineraryViewController: UIViewController{

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
    
    override func setEditing(editing: Bool, animated: Bool) {
       
        self.ItinTable.setEditing(!ItinTable.editing, animated: animated)
        if ItinTable.editing{
            self.navigationItem.rightBarButtonItem?.title = "Done"
        }
        else{
            self.navigationItem.rightBarButtonItem?.title = "Edit"
        }
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

//Mark: UITableViewDataSource and  UITableViewDelegate
extension ItineraryViewController:  UITableViewDataSource, UITableViewDelegate {

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete{
            self.myItenController.deleteFromMyIten(self.myItenController.getMyItenEvents()[indexPath.row])
            tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
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
        
        let destinationViewController: EventViewController
            = (storyboard?.instantiateViewControllerWithIdentifier("EventViewController") as? EventViewController)!
        
        let event = myItenController.getMyItenEvents()[indexPath.row]
        destinationViewController.event = event
        
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        ItinTable.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

}
