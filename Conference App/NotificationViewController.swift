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

//  NotificationViewController.swift
//  Conference App
//
//  Created by Felipe Brito {felipenevesbrito@gmail.com} on 5/11/16.


import UIKit

class NotificationViewController: UITableViewController{
    
    /// The Notification Handler
    let notificationController = NotificationController()
    
    override func viewDidLoad() {
        UIconfig()
    }
    
    /**
        Configures the UI's Layout, Color, Style...
    */
    internal func UIconfig(){
        self.tableView.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.view.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.tableView.tintColor = ItenWiredStyle.background.color.mainColor
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let notifications = notificationController.getAllNotifications()
        return notifications.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let notificationController = NotificationController()
        let notification = notificationController.getAllNotifications()[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("NotificationsCell") as? NotificationsCell
        
        cell?.build(notification)
        
        if notification.isDone == false {
            notification.setDone(true)
            notificationController.deleteNotification(notification)
            notificationController.addNotification(notification)
        }
        
        return cell!
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
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
