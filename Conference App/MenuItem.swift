//    Copyright (c) 2016, UWF
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
//    * Neither the name of UWF nor the names of its contributors may be used to
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

//  MenuItem.swift
//  Conference App
//  Created by Felipe Brito on 5/25/16.

import UIKit

// Item for the main menu
class MenuItem{
    
    ///Button's Destination View's Storyboard
    var storyboardId:String
    
    /// Button's destination view controller ID
    var viewControllerId:String
    
    /// Button's Name
    var name:String
    
    /// Buton's icon
    var image:UIImage
    
    /// Button's inverted color icon
    var invertedColorIcon:UIImage
    
    
    init(storyboardId: String, viewControllerId: String, name: String, imageUrl: String){
        self.storyboardId = storyboardId
        self.viewControllerId = viewControllerId
        self.name = name
        self.image = UIImage(named: imageUrl)!
        self.invertedColorIcon = UIImage(named: "\(imageUrl.componentsSeparatedByString(".")[0])-color.\(imageUrl.componentsSeparatedByString(".")[1])")!
    }
}



