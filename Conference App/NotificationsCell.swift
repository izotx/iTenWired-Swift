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
          //TODO: Change Layout
            self.messageLabel.font = UIFont.systemFontOfSize(17.0)
            self.dateLabel.font = UIFont.systemFontOfSize(17.0)
        }else{
           //TODO: Change Layout
            self.messageLabel.font = UIFont.boldSystemFontOfSize(17.0)
            self.dateLabel.font = UIFont.boldSystemFontOfSize(17.0)
        }
    }
    
    internal func UIConfig(){
    
        self.messageLabel.textColor = ItenWiredStyle.text.color.mainColor
        self.dateLabel.textColor = ItenWiredStyle.text.color.mainColor
    }
}
