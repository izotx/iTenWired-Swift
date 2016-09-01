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

//  speackerCell.swift
//  Conference App
//
//  Created by Felipe on 5/10/16.
//  Copyright © 2016 Izotx LLC. All rights reserved.
//


import UIKit
import Kingfisher

class SpeakerCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!

    @IBOutlet weak var photoImageView: UIImageView!
    
    func setName(name:String){
        self.nameLabel.text = name
    }
    
    func setJobTitle(title:String){
        self.jobTitleLabel.text = title
    }

    
    func build(speaker:Speaker){
        
        self.UIConfig()
        
        setName(speaker.name)
        
        
        if speaker.image != ""{
            //load it here 
            if let url = NSURL(string: speaker.image){
                photoImageView.kf_setImageWithURL(url)
            }
        }
        
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