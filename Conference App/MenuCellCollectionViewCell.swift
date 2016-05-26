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
    
    @IBOutlet weak var nameLabel: UILabel!
   
    @IBOutlet weak var icon: MIBadgeButton!


    
    
    func build(menuItem:MenuItem){
        self.nameLabel.text = menuItem.name
        
        icon.setImage(menuItem.image, forState: .Normal)
        
       self.UIConfig()
    }
    
    internal func UIConfig(){
        self.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.nameLabel.textColor = ItenWiredStyle.text.color.mainColor
        
        self.contentView.layer.borderColor = ItenWiredStyle.background.color.invertedColor.CGColor
        
        self.contentView.layer.borderWidth = 2
        
        self.icon.backgroundColor = ItenWiredStyle.background.color.mainColor
    }
    
}

class MenuLongCellCollectionViewCell:MenuCellCollectionViewCell{


}
