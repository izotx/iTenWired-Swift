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
//
//  NearMeCollectionViewCell.swift
//  Conference App
//
//  Created by Felipe N. Brito on 7/8/16.
//
//

import UIKit
import Haneke


class NearMeCollectionViewCell: UICollectionViewCell {
    
    var nearMeItem: iBeaconNearMeProtocol!
    
//    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var itemTypeLabel: UILabel!

    @IBOutlet weak var imageView: UIImageView!
 //   @IBOutlet var icon: MIBadgeButton!
    
    @IBOutlet var title: UILabel!
    
    override var bounds: CGRect {
        didSet {
            contentView.frame = bounds
        }
    }

    
    func build(nearMeItem: iBeaconNearMeProtocol){
        
       // icon.hnk_setImageFromURL(NSURL(string: nearMeItem.getNearMeIconURL())!)
        title.text = nearMeItem.getNearMeTitle()
        itemTypeLabel.text = "" 
        if nearMeItem is Sponsor{
            itemTypeLabel.text = "Sponsor"
        }
        if nearMeItem is Exhibitor{
            itemTypeLabel.text = "Exhibitor"
        }

        if nearMeItem is Location{
            itemTypeLabel.text = "Location"
        }

        
        
        self.UIConfig()
    }
    
    internal func UIConfig(){
        self.backgroundColor = ItenWiredStyle.background.color.invertedColor
       
        title.textColor = ItenWiredStyle.text.color.mainColor
        
        self.contentView.layer.borderColor = ItenWiredStyle.background.color.mainColor.CGColor
        
        self.contentView.layer.borderWidth = 1
        
//        self.containerView.layer.borderWidth = 1
//        self.containerView.layer.borderColor = UIColor.greenColor().CGColor        
//        self.imageView.layer.borderColor = UIColor.whiteColor().CGColor
//        self.imageView.layer.borderWidth = 2
        
        
    }
    
}

