//
//  PhotoRecordState.swift
//  Conference App
//
//  Created by Felipe on 5/12/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit

// This enum contains all the possible states a photo record can be
enum PhotoRecordState {
    case New, Downloaded, Filtered, Failed
}


class Photorecord {

    let name:String
    let url:NSURL
    var state = PhotoRecordState.New
    var image:UIImage!
    
    
    init(name:String, url:NSURL){
        self.name = name
        self.url = url
        self.image = UIImage(named : "placeholder.png")
    }
}