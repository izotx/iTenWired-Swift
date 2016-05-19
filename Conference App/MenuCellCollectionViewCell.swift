//
//  MenuCellCollectionViewCell.swift
//  Conference App
//
//  Created by Felipe on 5/19/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit

class MenuCellCollectionViewCell: UICollectionViewCell {
    
    var menuItem:MenuItem!
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    func build(menuItem:MenuItem){
        self.nameLabel.text = menuItem.name
        self.icon.image = menuItem.image
        
        self.UIConfig()
    }
    
    internal func UIConfig(){
        self.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.nameLabel.textColor = ItenWiredStyle.text.color.mainColor
    }
    
}
