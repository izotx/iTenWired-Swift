//    Copyright (c) 2016, Izotx
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
//    * Neither the name of Izotx nor the names of its contributors may be used to
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

//  EventViewController.swift
//  Agenda1
//
//  Created by Felipe Neves Brito on 4/8/16.
//  Copyright © 2016 Felipe Neves Brito. All rights reserved
//

import UIKit

class EventViewController: UIViewController{
    var event:Event?
    
   // @IBOutlet var NameLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
  
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollviewView: UIView!

    @IBOutlet weak var tableView: UITableView!

    let attendeeController = AttendeeController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIConfig()
        
        // TableView Delegate
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    internal func UIConfig(){
        
        
        if event?.presentorsIDs.count <= 0 {
            self.tableView.hidden = true
        }
        
        summaryLabel.text = event?.summary
        titleLabel.text = event?.name
        
        // Resize the tableview and scrollview
        resizeTableview()
        resizeScrollView()
        
        self.view.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.summaryLabel.textColor = ItenWiredStyle.text.color.mainColor
        self.titleLabel.textColor = ItenWiredStyle.text.color.mainColor
        self.scrollView.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.scrollviewView.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.tableView.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.navigationController?.navigationBarHidden = false
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
}

//MARK: UITableViewDataSource, UITableViewDelegate
extension EventViewController : UITableViewDataSource, UITableViewDelegate{

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("speakerHeaderCell") as? SpeakerHeaderCell
        
        headerCell?.build()
        return headerCell
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("speakerCell", forIndexPath: indexPath) as? SpeakerCell
        
        let presenterId = self.event?.presentorsIDs[indexPath.row]
        let presenter = self.attendeeController.getSpeakerById(presenterId!)
        
        cell?.build(presenter!)
        cell?.invertTheme()
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = (event?.presentorsIDs.count)!
        
        tableView.contentSize = CGSize(width: tableView.contentSize.width, height: CGFloat(count) * 40.00)
        
        return count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let speakerID = self.event?.presentorsIDs[indexPath.row],
            let speaker = self.attendeeController.getSpeakerById(speakerID) else{
                
                return
        }
        
        let storyboard = UIStoryboard.init(name: "Attendees", bundle: nil)
        
        let destinationViewController = storyboard.instantiateViewControllerWithIdentifier("SpeakerDescriptionViewController") as? SpeakerDescriptionViewController
        
        
        destinationViewController?.speaker = speaker
        
        self.navigationController?.pushViewController(destinationViewController!, animated: true)
    }
}
