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
        
        let about = aboutData.getAbout()
        
        // Initial VC Styling
        descriptionLabel.text = about.description
        
        if let url = NSURL(string:about.image) {
            let data = NSData(contentsOfURL:url)
        
            if(data != nil){
                imageURL.image = UIImage(data:data!)
                imageURL.contentMode = .ScaleAspectFit
            }
        }
        
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
