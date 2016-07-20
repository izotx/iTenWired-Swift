//    Copyright (c) 2016, Izotx
//    All rights reserved.
//
//    Redistribution and use in source and binary forms, with or without
//    modification, are permitted provided that the following conditions are met:
//
//    * Redistributions of source code must retain the above copyright notice,
//    this list of conditions and the following disclaimer.
//    * Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
//    * Neither the name of Izotx nor the names of its contributors may be used to
//    endorse or promote products derived from this software without specific
//    prior written permission.
//
//    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//    ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
//    LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//    CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//    SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//    INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//    CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//    ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//    POSSIBILITY OF SUCH DAMAGE.

//  MenuCellCollectionViewCell.swift
//  Conference App
//
//  Created by Felipe on 5/19/16.

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
