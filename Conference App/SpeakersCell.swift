//
//  SpeakersCell.swift
//  Conference App
//
//  Created by tuong on 4/15/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit


class SpeakersCell: UITableViewCell {
    
    
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var Title: UILabel!
    
    func setName(name:String){
        nameLabel.text = name
    }
    
    func setLogo(logo:String)
    {
        let url = NSURL(string:logo)
        let data = NSData(contentsOfURL:url!)
        if (data != nil) {
            
            logoImage.image = UIImage(data:data!)
            logoImage.contentMode = .ScaleAspectFit
        }
    }
    
    func setjobTitle(title:String)
    {
        Title.text = title
    }
    
}