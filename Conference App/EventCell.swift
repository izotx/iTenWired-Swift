//
//  EventCell.swift
//  Agenda1
//
//  Created by Felipe Neves Brito on 4/5/16.
//  Copyright © 2016 Felipe Neves Brito. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet var nameLable: UILabel!
    
    @IBOutlet var timeLable: UILabel!
    
    @IBOutlet weak var view: UIView!

    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet var dateLable: UILabel!
    
    @IBOutlet var timeStopLable: UILabel!
    
    var event:Event!
    
    func setName(name:String){
        nameLable.text = name
    }
    
    func setStartTime(time:String){
        timeLable.text = time
    }
    
    func setStopTime(time:String){
        timeStopLable.text = time
    }
    
    func setDate(date:String){
        let day = date.componentsSeparatedByString("/")[1]
        dateLable.text = day
    }
    
    func build(event:Event){
       self.UIConfig()
        self.setName(event.name)
        self.setStartTime(event.timeStart)
        self.setStopTime(event.timeStop)
        self.setDate(event.date)
        self.event = event
    }
    
    internal func UIConfig(){
        self.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.nameLable.textColor = ItenWiredStyle.text.color.mainColor
        self.timeLable.textColor = ItenWiredStyle.text.color.mainColor
        self.dateLable.textColor = ItenWiredStyle.text.color.mainColor
        self.timeStopLable.textColor = ItenWiredStyle.text.color.mainColor
        
        if let view = self.view {
            view.backgroundColor = ItenWiredStyle.background.color.mainColor
        }
    }
    
    func setStartButton(isPresentMyIten: Bool){
        if isPresentMyIten {
            self.addButton.setImage(UIImage(named: "StarFilled-50.png"), forState: UIControlState.Normal)
        } else {
            self.addButton.setImage(UIImage(named: "Star-50.png"), forState: UIControlState.Normal)
        }
    }
  
    
    @IBAction func addMyItenAction(sender: AnyObject) {
        let myItenController = MyItenController()
        
        if myItenController.isPresent(event) {
            myItenController.deleteFromMyIten(event)
            self.addButton.setImage(UIImage(named: "Star-50.png"), forState: UIControlState.Normal)
        } else {
            myItenController.addToMyIten(event)
            self.addButton.setImage(UIImage(named: "StarFilled-50.png"), forState: UIControlState.Normal)
        }
    }
}
