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

//  SponserUIViewController.swift
//  Conference App
//
//  Created by Felipe Brito {felipenevesbrito@gmail.com} on 5/24/16.
//
//

import UIKit

class SponserUIViewController: UIViewController {

    var sponser:Sponser!
    var exhibitor:Exibitor!
    
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var websiteLabel: UILabel!
    
    
    override func viewDidLoad() {
        
        if let sponser = self.sponser{
            self.build(sponser)
        }else if let exhibitor = self.exhibitor{
            self.build(exhibitor)
        }
        
        
        self.UIConfig()
    }
    
    func build(exhibitor: Exibitor){
        // Gets the logo from the url
        if NetworkConnection.isConnected() {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                guard let url = NSURL(string: exhibitor.logo),
                    let data = NSData(contentsOfURL: url) else {
                        return
                }
                self.logo.image = UIImage(data: data)
            }
        }
        
        self.nameLabel.text = exhibitor.name
        self.descriptionLabel.text = exhibitor.description
        self.websiteLabel.text = exhibitor.website
    }
    
    func build(sponser: Sponser){
        // Gets the logo from the url
        if NetworkConnection.isConnected() {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                guard let url = NSURL(string: self.sponser.logo),
                    let data = NSData(contentsOfURL: url) else {
                        return
                }
                self.logo.image = UIImage(data: data)
            }
        }
        
        self.nameLabel.text = sponser.name
        self.descriptionLabel.text = sponser.description
        self.websiteLabel.text = sponser.website
    }
    
    internal func UIConfig(){
        self.nameLabel.textColor = ItenWiredStyle.text.color.invertedColor
        self.descriptionLabel.textColor = ItenWiredStyle.text.color.invertedColor
        self.websiteLabel.textColor = ItenWiredStyle.text.color.invertedColor
        self.view.backgroundColor = ItenWiredStyle.background.color.invertedColor
    }
}
