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
    @IBOutlet weak var titleLabel: UILabel!
    
    func build(notification:Notification){
        self.UIConfig()
        
        self.messageLabel.text  = notification.message
        self.titleLabel.text = notification.title
        // Format the date
        let dateFormater = NSDateFormatter()
        dateFormater.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormater.timeStyle = NSDateFormatterStyle.ShortStyle
        
        let dateString = NSDateFormatter.localizedStringFromDate(notification.date, dateStyle: .ShortStyle, timeStyle: .ShortStyle)
        
        self.dateLabel.text = dateString
        
        if notification.isDone {
          //TODO: Change Layout
            self.messageLabel.font = UIFont.systemFontOfSize(13.0)
            self.dateLabel.font = UIFont.systemFontOfSize(16.0)
            self.titleLabel.font = UIFont.systemFontOfSize(22.0)
        }else{
           //TODO: Change Layout
            self.messageLabel.font = UIFont.boldSystemFontOfSize(13.0)
            self.dateLabel.font = UIFont.boldSystemFontOfSize(16.0)
            self.titleLabel.font = UIFont.boldSystemFontOfSize(22.0)
        }
    }
    
    internal func UIConfig(){
        self.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.messageLabel.textColor = ItenWiredStyle.text.color.mainColor
        self.dateLabel.textColor = ItenWiredStyle.text.color.mainColor
        self.titleLabel.textColor = ItenWiredStyle.text.color.mainColor
    }
}
