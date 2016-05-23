//
//  speakerHeaderCell.swift
//  Conference App
//
//  Created by Felipe on 5/23/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//



import UIKit

class SpeakerHeaderCell: UITableViewCell {
    func build(){
        self.UIConfig()
    }
    
    internal func UIConfig(){
        self.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.contentView.backgroundColor = ItenWiredStyle.background.color.mainColor
    }
}