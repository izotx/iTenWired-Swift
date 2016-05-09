//
//  AddAnnotation.swift
//  Conference App
//
//  Created by Julian L on 4/12/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation
import MapKit
import UIKit

// I created this because MKAnnotation wasn't displaying subtitle for some reason
class AddAnnotation: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var subtitle: String?
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.subtitle = info
    }
}