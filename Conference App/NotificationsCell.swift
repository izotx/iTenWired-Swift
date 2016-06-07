//    Copyright (c) 2016, UWF
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
//    * Neither the name of UWF nor the names of its contributors may be used to
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

//  NotificationsCell.swift
//  Agenda1
//
//  Created by Felipe Neves Brito on 5/11/16.

import UIKit

class NotificationsCell: UITableViewCell{
    
  
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    func build(notification:Notification){
        self.UIConfig()
        
        self.textView.text  = notification.message
        self.titleLabel.text = notification.title
        // Format the date
        let dateFormater = NSDateFormatter()
        dateFormater.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormater.timeStyle = NSDateFormatterStyle.ShortStyle
        
        let dateString = NSDateFormatter.localizedStringFromDate(notification.date, dateStyle: .ShortStyle, timeStyle: .ShortStyle)
        
        self.dateLabel.text = dateString
        
        if notification.isDone {
          //TODO: Change Layout
            self.textView.font = UIFont.systemFontOfSize(13.0)
            self.dateLabel.font = UIFont.systemFontOfSize(16.0)
            self.titleLabel.font = UIFont.systemFontOfSize(22.0)
        }else{
           //TODO: Change Layout
            self.textView.font = UIFont.boldSystemFontOfSize(13.0)
            self.dateLabel.font = UIFont.boldSystemFontOfSize(16.0)
            self.titleLabel.font = UIFont.boldSystemFontOfSize(22.0)
        }
    }

    internal func UIConfig(){
        self.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.textView.textColor = ItenWiredStyle.text.color.mainColor
        self.dateLabel.textColor = ItenWiredStyle.text.color.mainColor
        self.titleLabel.textColor = ItenWiredStyle.text.color.mainColor
        self.textView.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.textView.tintColor = ItenWiredStyle.text.color.mainColor
    }
  
}

