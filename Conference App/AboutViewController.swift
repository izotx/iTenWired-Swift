//
//  AboutViewController.swift
//  Conference App
//
//  Created by Julian L on 4/8/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    
    var about: AboutData = AboutData()
    
    @IBOutlet var aboutTextView: UITextView!
    
    @IBOutlet var imageURL: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial VC Styling
        self.view.backgroundColor = UIColor(red: 0.15, green: 0.353, blue: 0.6, alpha: 100)
        aboutTextView.textColor = UIColor(red: 1, green: 0.63, blue: 0, alpha: 100)
        
        if let aboutText = about.content as? String {
            aboutTextView.text = aboutText
        }
        if let logoText = about.logo as? String {
            let url = NSURL(string:logoText)
            let data = NSData(contentsOfURL:url!)
            if (data != nil) {
                //let tempImg = UIImage(data:data!)
                imageURL.image = UIImage(data:data!)
                imageURL.contentMode = .ScaleAspectFit
            }
        }
        
        aboutTextView.scrollRangeToVisible(NSMakeRange(0, 0))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    //Displays Menu When clicked
    @IBAction func showMenu(sender: AnyObject) {
        
        let rightNavController = splitViewController!.viewControllers.last as! UINavigationController
        
        rightNavController.popToRootViewControllerAnimated(true)
    }

    
    
  
    
    
}
