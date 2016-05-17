//
//  EventViewController.swift
//  Agenda1
//
//  Created by Felipe Neves Brito on 4/8/16.
//  Copyright © 2016 Felipe Neves Brito. All rights reserved
//

import UIKit

class EventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var event:Event?
    
   // @IBOutlet var NameLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
  
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var tableView: UITableView!

    let attendeeController = AttendeeController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableView Delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
        summaryLabel.text = event?.summary
        titleLabel.text = event?.name
        
        // Resize the tableview and scrollview
        resizeTableview()
        resizeScrollView()
        
        
        if event?.presentorsIDs.count <= 0 {
            self.tableView.hidden = true
        }
    }
    
    func resizeScrollView(){
        var scrollViewHeight:CGFloat = 0.0
        
        for view in scrollView.subviews {
            let height = view.frame.size.height + view.frame.origin.y
            if Double(height) > Double(scrollViewHeight) {
                scrollViewHeight = height
            }
        }
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: scrollViewHeight)
    }
    
    func resizeTableview(){
        var tableViewHeight:CGFloat = 0.0
        
        
        for view in tableView.subviews {
            let height = view.frame.size.height + view.frame.origin.y
            if Double(height) > Double(tableViewHeight) {
                tableViewHeight = height
            }
        }
        
        self.tableView.contentSize = CGSize(width: self.tableView.frame.size.width, height: tableViewHeight)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("speakerHeaderCell")
        return headerCell
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("speakerCell", forIndexPath: indexPath) as? SpeakerCell
        
        let presenterId = self.event?.presentorsIDs[indexPath.row]
        let presenter = self.attendeeController.getSpeakerById(presenterId!)
        
        cell?.build(presenter!)
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = (event?.presentorsIDs.count)!
        
        tableView.contentSize = CGSize(width: tableView.contentSize.width, height: CGFloat(count) * 40.00)
        
        return count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}


