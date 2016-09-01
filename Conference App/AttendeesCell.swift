//
//  AttendeesCell.swift
//  Conference App
//
//  Created by tuong on 4/11/16.
//  Copyright © 2016 Izotx LLC. All rights reserved.
//

import UIKit
//event
class AttendeesCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var Title: UILabel!  //FIXME:    rename to "level:
    @IBOutlet weak var logoView: UIImageView!
    
    
    
    
    func build(sponser:Sponsor){
        setName(sponser.name)
        setLevel(sponser.level)
    }
    
    func build(exibitor:Exhibitor){
        setName(exibitor.name)
        setLevel(exibitor.website)
    }
    
    func setName(name:String){
        nameLabel.text = name
    }
    
    func setProfileImage(photoDetails : Photorecord){
        self.logoView.image = photoDetails.image!
    }
    
    func setLevel(level:String)
    {
        Title.text = level
    }
}