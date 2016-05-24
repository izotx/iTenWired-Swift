//
//  DescriptionViewController.swift
//  Conference App
//
//  Created by tuong on 5/17/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit
//description
class SpeakerDescriptionViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var job: UILabel!

    @IBOutlet weak var componentsView: UIView!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var speaker:Speaker! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.build(speaker!)
        resizeScrollView()
        
        self.UIConfig()
    }
    
    internal func UIConfig(){
        self.view.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.scrollView.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.componentsView.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.nameLabel.textColor = ItenWiredStyle.text.color.mainColor
        self.job.textColor = ItenWiredStyle.text.color.mainColor
        self.bioLabel.textColor = ItenWiredStyle.text.color.mainColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func build(speaker:Speaker){
        self.nameLabel.text = speaker.name
        self.job.text = "\(speaker.jobTitle) \n at"
        self.companyLabel.text = speaker.company
        self.bioLabel.text = speaker.bio
    }
    
    func resizeScrollView(){
        var scrollViewHeight:CGFloat = 0.0
        view.layoutIfNeeded()
        for view in scrollView.subviews {
            let height = view.frame.size.height + view.frame.origin.y
            if Double(height) > Double(scrollViewHeight) {
                scrollViewHeight = height
            }
        }
        //Margin hack
        let margin:CGFloat = 140.0
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: scrollViewHeight + margin)
    }
    @IBAction func sendEmail(sender: AnyObject) {
        if let url = NSURL(string: "mailto:\(speaker.email)") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func openLinkedIn(sender: AnyObject) {
        if let url = NSURL(string: speaker.linkedin) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func openWeb(sender: AnyObject) {
        if let url = NSURL(string: speaker.website) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    
    
    
    
    
    
    
}