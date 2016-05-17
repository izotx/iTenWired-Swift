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
        aboutTextView.text = about.content
        
        if let url = NSURL(string:about.logo) {
            let data = NSData(contentsOfURL:url)
        
            if(data != nil){
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
}
