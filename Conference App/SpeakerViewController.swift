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

//  DescriptionViewController.swift
//  Conference App
//
//  Created by tuong on 5/17/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit
//description
class SpeakerDescriptionViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var job: UILabel!

    @IBOutlet weak var componentsView: UIView!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var speaker:Speaker! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        build(speaker!)
        UIConfig()
    }
    
    internal func UIConfig(){
        resizeScrollView()
        self.view.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.scrollView.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.componentsView.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.nameLabel.textColor = ItenWiredStyle.text.color.mainColor
        self.job.textColor = ItenWiredStyle.text.color.mainColor
        self.bioLabel.textColor = ItenWiredStyle.text.color.mainColor
    }
    
    func build(speaker:Speaker){
        self.nameLabel.text = speaker.name
        self.job.text = "\(speaker.jobTitle) \n at"
        self.companyLabel.text = speaker.company
        self.bioLabel.text = speaker.bio
    }
    
    func resizeScrollView(){
        var scrollViewHeight:CGFloat = 0.0
        view.layoutIfNeeded()
        for view in scrollView.subviews {
            let height = view.frame.size.height + view.frame.origin.y
            if Double(height) > Double(scrollViewHeight) {
                scrollViewHeight = height
            }
        }
        //Margin hack
        let margin:CGFloat = 140.0
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: scrollViewHeight + margin)
    }
    @IBAction func sendEmail(sender: AnyObject) {
        if let url = NSURL(string: "mailto:\(speaker.email)") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func openLinkedIn(sender: AnyObject) {
        if let url = NSURL(string: speaker.linkedin) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func openWeb(sender: AnyObject) {
        if let url = NSURL(string: speaker.website) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
}