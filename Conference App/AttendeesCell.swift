//
//  AttendeesCell.swift
//  Conference App
//
//  Created by tuong on 4/11/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit
//event
class AttendeesCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var Title: UILabel!  //FIXME:    rename to "level:
    @IBOutlet weak var logoView: UIImageView!
    
    
    
    
    func build(sponser:Sponser){
        setName(sponser.name)
        setLogo(sponser.logo)
        setLevel(sponser.level)
    }
    
    func build(exibitor:Exibitor){
        setName(exibitor.name)
        setLogo(exibitor.logo)
        setLevel(exibitor.website)
    }
    
    func setName(name:String){
        nameLabel.text = name
    }
    
    func setLogo(logo:String)
    {
        let imageData = NSData(contentsOfURL: NSURL(string: logo)!)
        self.logoView.image = UIImage(data: imageData!)
        
        logoView.layer.cornerRadius = 10
        logoView.layer.masksToBounds = true
    }
    
    func setProfileImage(photoDetails : Photorecord){
        self.logoView.image = photoDetails.image!
    }
    
    func setLevel(level:String)
    {
        Title.text = level
    }
    
  
}