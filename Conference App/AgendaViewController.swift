//
//  ViewController.swift
//  Agenda1
//
//  Created by Felipe Neves Brito on 4/5/16.
//  Copyright © 2016 Felipe Neves Brito. All rights reserved.
//

import UIKit

class AgendaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var agendaController:AgendaController = AgendaController()

    @IBOutlet weak var tableView: UITableView!
    
    
    let myItenController = MyItenController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
         self.navigationController?.navigationBarHidden = false
        
        //TablewView delegate 
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = 85.0
        self.tableView.rowHeight = UITableViewAutomaticDimension     // Sets the table view's row height to automatic
        
        if let splitController = self.splitViewController{
            
            if !splitController.collapsed {
                splitController.toggleMasterView()
                
            }
        }
        
        
        let loginView : FBSDKLoginManager = FBSDKLoginManager()
        
        loginView.loginBehavior = FBSDKLoginBehavior.Browser
        
        loginView.logInWithReadPermissions(["email"], fromViewController: self, handler: { (result : FBSDKLoginManagerLoginResult!, error : NSError!) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                
                print("Login Error")
            }
            else if result.isCancelled {
                // Handle cancellations
                print("canceled")
            }
            else {
                
                let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "itenwired/posts", parameters: ["fields": "message"], tokenString: result.token.tokenString, version: nil, HTTPMethod: nil)//(graphPath: "me", parameters:["fields": "email"])
                graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                    
                    
                    if let e = error {
                        
                    }else {
                        
                        
                        print(result.valueForKey("data"))
                    }
                    
                })
                
            }
            
            
            print()
        })
        
       /* loginView.logInWithReadPermissions(["email"], handler: { (result : FBSDKLoginManagerLoginResult!, error : NSError!) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                
                print("Login Error")
            }
            else if result.isCancelled {
                // Handle cancellations
            }
            else {
                
              
            }
            
            
            print()
        })*/
        
        
        
//       let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email"], tokenString: "466708945348493d570cb2f5079f9b6a", version: nil, HTTPMethod: nil)//(graphPath: "me", parameters:["fields": "email"])
//        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
//            
//            print("HERE")
//            
//            if let e = error {
//                print(error)
//                print("ERROR FACE!!")
//            }else {
//                let facebookID: NSString = (result.valueForKey("email") as? NSString)!
//                
//                print(facebookID)
//            }
//            
//        })
    
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.UIConfig()
        let appData = AppData()
        if NetworkConnection.isConnected(){
            appData.saveData()
        }
    }
    
    internal func UIConfig(){
        tableView.backgroundColor = ItenWiredStyle.background.color.mainColor
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if(section == 0){
            return agendaController.getEventsCount()
        }
        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! EventCell
        let event = agendaController.getEventAt(indexPath.row)
        
        //builds cell data
        cell.build(event)
        cell.setStartButton(myItenController.isPresent(event))
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("dateCell") as? AgendaHeaderTableViewCell
        
        let event = self.agendaController.getAgenda().events[0]
        
        let date = event.date
        
        
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
            
            let event = self.agendaController.getEventAt(indexPath.row)
            destinationViewController.event = event
            
            self.navigationController?.pushViewController(destinationViewController, animated: true)
       
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

