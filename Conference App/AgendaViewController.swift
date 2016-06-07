//
//  ViewController.swift
//  Agenda1
//
//  Created by Felipe Neves Brito on 4/5/16.
//  Copyright © 2016 Felipe Neves Brito. All rights reserved.
//

import UIKit

class AgendaViewController: UIViewController{

    var events: [Event] = []

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    let myItenController = MyItenController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadEvents()
        
        //TablewView delegate 
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.UIConfig()
    }
    
    internal func loadEvents(){
    
        let agendaDataLoader = AgendaDataLoader()
        
        activityIndicator.startAnimating()
        activityIndicator.hidden = false 
        agendaDataLoader.getEvents { (events) in
            self.events.appendContentsOf(events)
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    internal func UIConfig(){
        tableView.backgroundColor = ItenWiredStyle.background.color.mainColor
       
        self.navigationController?.navigationBarHidden = false
        self.tableView.estimatedRowHeight = 85.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        if let splitController = self.splitViewController{
            
            if !splitController.collapsed {
                splitController.toggleMasterView()
                
            }
        }
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
extension AgendaViewController: UITableViewDelegate, UITableViewDataSource{
    
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
//        cell.setStartButton(myItenController.isPresent(event))
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("dateCell") as? AgendaHeaderTableViewCell
        
        if events.count == 0{
            cell?.dateLabel.text = ""
            return cell
        }
        
        
        let date = events[0].date
        
        //FIXEME: Refactor
        let month = Int(date.componentsSeparatedByString("/")[0])
        let year = date.componentsSeparatedByString("/")[2]
        
        var monthString = ""
        
        switch(month!){
        case 1: monthString = DateEnum.January.rawValue
            break
            
        case 2: monthString = DateEnum.Feburary.rawValue
            break
            
        case 3: monthString = DateEnum.March.rawValue
            break
            
        case 4: monthString = DateEnum.April.rawValue
            break
            
        case 5: monthString = DateEnum.May.rawValue
            break
            
        case 6: monthString = DateEnum.June.rawValue
            break
            
        case 7: monthString = DateEnum.July.rawValue
            break
            
        case 8: monthString = DateEnum.Agust.rawValue
            break
            
        case 9: monthString = DateEnum.September.rawValue
            break
            
        case 10: monthString = DateEnum.October.rawValue
            break
            
        case 11: monthString = DateEnum.November.rawValue
            break
            
        case 5: monthString = DateEnum.December.rawValue
            break
            
        default:
            break
        }
        
        cell?.dateLabel.text = "\(monthString) \(year)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let destinationViewController: EventViewController
            = (storyboard?.instantiateViewControllerWithIdentifier("EventViewController") as? EventViewController)!
        
        let event = events[indexPath.row]
        destinationViewController.event = event
        
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }

}