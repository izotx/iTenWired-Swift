//
//  NotificationsCell.swift
//  Agenda1
//
//  Created by Felipe Neves Brito on 5/11/16.
//  Copyright © 2016 Felipe Neves Brito. All rights reserved.
//

import UIKit

class NotificationsCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
  
    
    func build(notification:Notification){
        self.messageLabel.text  = notification.message
        
        // Format the date
        let dateFormater = NSDateFormatter()
        dateFormater.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormater.timeStyle = NSDateFormatterStyle.ShortStyle
        
        let dateString = NSDateFormatter.localizedStringFromDate(notification.date, dateStyle: .ShortStyle, timeStyle: .ShortStyle)
        
        
        self.dateLabel.text = dateString
        
        
        if notification.isDone {
           self.backgroundColor = UIColor.whiteColor()
        }else{
            self.backgroundColor = UIColor.grayColor()
        }
    }
    
}
