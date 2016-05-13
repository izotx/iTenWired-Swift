//
//  speackerCell.swift
//  Conference App
//
//  Created by Felipe on 5/10/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//


import UIKit

class SpeakerCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!

    
    func setName(name:String){
        self.nameLabel.text = name
    }
    
    func setJobTitle(title:String){
        self.jobTitleLabel.text = title
    }

    
    func build(speaker:Speaker){
        setName(speaker.name)
        setJobTitle(speaker.jobTitle)
    }
}