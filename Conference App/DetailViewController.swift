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

//  DetailViewController.swift
//  Conference App
//
//  Created by B4TH Administrator on 4/1/16.

import UIKit


extension UISplitViewController {
    func toggleMasterView() {
        var nextDisplayMode: UISplitViewControllerDisplayMode
        switch(self.preferredDisplayMode){
        case .PrimaryHidden:
            nextDisplayMode = .AllVisible
        default:
            nextDisplayMode = .PrimaryHidden
        }
        UIView.animateWithDuration(0.5) { () -> Void in
            self.preferredDisplayMode = nextDisplayMode
        }
    }
}

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.valueForKey("timeStamp")!.description
            }
        }
    }
    
    @IBAction func changeSplitMode(sender: AnyObject) {
        //self.navigationController?.navigationController?.popToRootViewControllerAnimated(true)
        self.splitViewController?.toggleMasterView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        if !(self.splitViewController?.collapsed)!{
            
            let storyboard = UIStoryboard.init(name: "AgendaMain", bundle: nil)
            let destinationViewController = storyboard.instantiateViewControllerWithIdentifier("AgendaInitial")
            splitViewController?.showDetailViewController(destinationViewController, sender: nil)
            
        }
    }
}