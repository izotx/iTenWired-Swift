//
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}