//
//  AboutViewController.swift
//  Conference App
//
//  Created by Julian L on 4/8/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    
    var aboutData: AboutData = AboutData()
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet var imageURL: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UIConfig()
        let about = aboutData.getAbout()
        
        self.imageURL.image = UIImage(named: "logo.png")
        // Initial VC Styling
        descriptionLabel.text = about.description
        
        if NetworkConnection.isConnected() {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                let url = NSURL(string: about.image)
                let data = NSData(contentsOfURL: url!)
                self.imageURL.image = UIImage(data: data!)
            }
        }
        
    }
    
    internal func UIConfig(){
        self.view.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.descriptionLabel.textColor = ItenWiredStyle.text.color.mainColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func showMenu(sender: AnyObject) {
        let rightNavController = splitViewController!.viewControllers.last as! UINavigationController
        
        rightNavController.popToRootViewControllerAnimated(true)
    }
    
}
