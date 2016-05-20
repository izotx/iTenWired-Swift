//
//  TableViewCell.swift
//  Conference App
//
//  Created by Felipe on 5/20/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit

class AgendaHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var dateView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.UIConfig()
        
    }
    
    internal func UIConfig(){
        self.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.dateLabel.textColor = ItenWiredStyle.text.color.mainColor
        self.contentView.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.dateView.backgroundColor = ItenWiredStyle.background.color.mainColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
