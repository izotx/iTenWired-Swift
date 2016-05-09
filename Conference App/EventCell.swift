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
    
    
    @IBOutlet var dateLable: UILabel!
    
    @IBOutlet var timeStopLable: UILabel!
    
    @IBOutlet weak var swipeImageView: UIImageView!
    
    
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
        dateLable.text = date
    }
    
    func showSwipe(bool:Bool){
        if bool {
            
        }else{
            if let swipeImg = self.swipeImageView {
                swipeImg.removeFromSuperview()
            }
            //self.swipeImageView.removeFromSuperview()
        }
    }
}
