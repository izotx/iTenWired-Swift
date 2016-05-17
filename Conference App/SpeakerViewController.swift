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
    
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var companyLabel: UILabel!
    
    var speaker:Speaker! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.build(speaker!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func build(speaker:Speaker){
        self.nameLabel.text = speaker.name
        self.job.text = "\(speaker.jobTitle) \n at"
        self.companyLabel.text = speaker.company
        self.bioTextView.text = speaker.bio
    }
}