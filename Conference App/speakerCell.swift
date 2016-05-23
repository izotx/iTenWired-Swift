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
        
        self.UIConfig()
        
        setName(speaker.name)
        
        if speaker.jobTitle != "" && speaker.company != ""{
            setJobTitle("\(speaker.jobTitle) at \(speaker.company)")
        }
        
        else if speaker.jobTitle != "" {
            setJobTitle(speaker.company)
        }
        
        else if speaker.company != "" {
            setJobTitle(speaker.company)
        }
        
        else{
            setJobTitle("")
        }
    }
    
    internal func UIConfig(){
        self.backgroundColor = ItenWiredStyle.background.color.invertedColor
        self.nameLabel.textColor = ItenWiredStyle.text.color.invertedColor
        self.jobTitleLabel.textColor = ItenWiredStyle.text.color.invertedColor
    }
    
    func invertTheme(){
        self.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.nameLabel.textColor = ItenWiredStyle.text.color.mainColor
        self.jobTitleLabel.textColor = ItenWiredStyle.text.color.mainColor
    }
    
    
}