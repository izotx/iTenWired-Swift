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
    
    func build(notification:Notification){
        self.messageLabel.text  = notification.message
    }
    
}
