//
//  DetailViewController.swift
//  Conference App
//
//  Created by B4TH Administrator on 4/1/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit


extension UISplitViewController {
    func toggleMasterView() {
        var nextDisplayMode: UISplitViewControllerDisplayMode
        switch(self.preferredDisplayMode){
        case .PrimaryHidden:
            nextDisplayMode = .AllVisible
        default:
            nextDisplayMode = .PrimaryHidden
        }
        UIView.animateWithDuration(0.5) { () -> Void in
            self.preferredDisplayMode = nextDisplayMode
        }
    }
}

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.valueForKey("timeStamp")!.description
            }
        }
    }

    
    @IBAction func changeSplitMode(sender: AnyObject) {
        //self.navigationController?.navigationController?.popToRootViewControllerAnimated(true)
        self.splitViewController?.toggleMasterView()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        if !(self.splitViewController?.collapsed)!{
            
            let storyboard = UIStoryboard.init(name: "AgendaMain", bundle: nil)
            let destinationViewController = storyboard.instantiateViewControllerWithIdentifier("AgendaInitial")
            splitViewController?.showDetailViewController(destinationViewController, sender: nil)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

