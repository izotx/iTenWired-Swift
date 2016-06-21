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

//  DescriptionViewController.swift
//  Conference App
//
//  Created by tuong on 4/20/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit
//description
class AttendeeDescription: UIViewController {
    
    var event:Event?
    
    @IBOutlet weak var Name: UILabel!
   
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var Descriptions: UILabel!
    
    var detailEvent: Event? {
        didSet {
            configureView()
        }
    }
    func configureView() {
        if let detailEvent = detailEvent {
            
            if let detailDescriptionLabel = Name, description = Descriptions {
                detailDescriptionLabel.text = detailEvent.name
                description.text = detailEvent.description
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UIConfig()
        // Do any additional setup after loading the view, typically from a nib.
        // load
      configureView()
    }
    
    internal func UIConfig(){
        self.view.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.Name.textColor = ItenWiredStyle.text.color.mainColor
        self.website.textColor = ItenWiredStyle.text.color.mainColor
        self.Descriptions.textColor = ItenWiredStyle.text.color.mainColor
    }
}