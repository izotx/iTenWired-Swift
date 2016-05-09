//
//  EventViewController.swift
//  Agenda1
//
//  Created by Felipe Neves Brito on 4/8/16.
//  Copyright © 2016 Felipe Neves Brito. All rights reserved
//

import UIKit

class EventViewController: UIViewController {
    
    var event:Event?
    
    @IBOutlet var NameLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NameLabel.text = event!.name
        summaryLabel.text = event!.summary
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


