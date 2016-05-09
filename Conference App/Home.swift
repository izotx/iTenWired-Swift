//
//  Home.swift
//  Conference App
//
//  Created by B4TH Administrator on 4/8/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit
//public var Vc: [UIViewController] = [MasterViewController.]

class Home: UITableViewController {
    var currVc: [UIViewController] = [/*Vc[1], */Vc[3], Vc[5], Vc[4]] ///*Maps*/, My Iten, Live Broadcast, Social Media
    //@IBOutlet weak var HomeStack: UIStackView!
    //@IBOutlet weak var ScrollView: UIScrollView!
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
        //tableView.reloadData()
        //let q = Vc[0]
        //let tvc = q.childViewControllers[0] as! UITableViewController
        //tvc.tableView.reloadData()
    }

    override func viewDidLoad() {
        //ScrollView.translatesAutoresizingMaskIntoConstraints = false
        //HomeStack.translatesAutoresizingMaskIntoConstraints = false
        
        super.viewDidLoad()
        super.restorationIdentifier = "HomeScreen"
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //let q = Vc[0]
        //let tvc = q.childViewControllers[0] as! UITableViewController
        //tvc.tableView.reloadData()
        
 //       tableView.reloadData()
        //self.viewDidLoad()
        //self.refreshControl?.beginRefreshing()
        // Do any additional setup after loading the view.
                //Sbd = UIStoryboard.init(name: "MapView", bundle: nil)
        //dViewController = Sbd!.instantiateViewControllerWithIdentifier("MapStoryboard")
        //Vc.append(dViewController)
        /*var Sbd:UIStoryboard? = UIStoryboard.init(name: "AboutView", bundle: nil)
        var dViewController:UIViewController = Sbd!.instantiateViewControllerWithIdentifier("AboutView")
        Vc.append(dViewController)
        //Sbd = UIStoryboard.init(name: "ItineraryStoryboard", bundle: nil)
        //dViewController = Sbd!.instantiateViewControllerWithIdentifier("Itinerary")
        Sbd = UIStoryboard.init(name: "Attendees", bundle: nil)
        dViewController = Sbd!.instantiateViewControllerWithIdentifier("Attendee")
        Vc.append(dViewController)

        
        Sbd = UIStoryboard.init(name: "AgendaMain", bundle: nil)
        dViewController = Sbd!.instantiateViewControllerWithIdentifier("AgendaInitial")
        Vc.append(dViewController)
        self.refreshControl?.endRefreshing()*/
        
        
        
        //Sbd = UIStoryboard.init(name: )
        //Sbd = UIStoryboard.init(name: "AgendaMain", bundle: nil)
        //dViewController = Sbd!.instantiateViewControllerWithIdentifier("AgendaInitial")
        //Vc[3] = dViewController
        //Sbd = UIStoryboard.init(name: "Home", bundle: nil)
        //dViewController = Sbd!.instantiateViewControllerWithIdentifier("Home")
        //Vc[0] = dViewController
        //let f = UINavigationController(rootViewController: self)
        
        //f.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        //f.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        //f.title = "iTen Wired"
        //f.addChildViewController(self)
        //self.addChildViewController(f)
        
        
        
        //for i in 0...2{
            //Vc[i].view!.sizeThatFits(CGSize(width: self.view!.width, height: self.view!.height/40.0))
            //HomeStack.addArrangedSubview(Vc[i].view)
            //ScrollView.sizeToFit()
            //ScrollView.
        //}
        /*var contentRect: CGRect = CGRectZero
        for view in 0...ScrollView.subviews.count-1 {
            let viewF:UIView = ScrollView.subviews[view]
            contentRect = CGRectUnion(contentRect, viewF.frame);
        }*/
        
        //ScrollView.contentSize = contentRect.size;
        //ScrollView.Subview  HomeStack.resizableSnapshotViewFromRect(<#T##rect: CGRect##CGRect#>, afterScreenUpdates: <#T##Bool#>, withCapInsets: <#T##UIEdgeInsets#>)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return currVc.count;
        super.tableView(tableView, numberOfRowsInSection: section)
        //tableView.reloadData()
        //////let q = Vc[0]
        ////let tvc = q.childViewControllers[0] as! UITableViewController
        ////tvc.tableView.reloadData()
        return currVc.count
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        let cell = tableView.dequeueReusableCellWithIdentifier("window", forIndexPath: indexPath)
        //cell.contentView = Vc[indexPath.row].view
        //print("Prop");
        cell.backgroundView = currVc[indexPath.row].view
        cell.backgroundColor = UIColor.clearColor()
        cell.contentView.addSubview(currVc[indexPath.row].view)
        cell.contentMode = .ScaleToFill
        cell.userInteractionEnabled = true
        //tableView.reloadData()
        ////let q = Vc[0]
        //let tvc = q.childViewControllers[0] as! UITableViewController
        //tvc.tableView.reloadData()
        return cell
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //tableView.reloadData()
        ////let q = Vc[0]
        //let tvc = q.childViewControllers[0] as! UITableViewController
        //tvc.tableView.reloadData()
        //ScrollView.contentSize = CGSize(width: HomeStack.frame.width, height: HomeStack.frame.height)
    }
    /*override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){
        super.tableView(tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath)
        
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
