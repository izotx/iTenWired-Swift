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

//  AnnotationDetailViewController.swift
//  Conference App
//
//  Created by Julian L on 4/13/16.

import UIKit
import MapKit
import CoreLocation

class AnnotationDetailViewController: UIViewController {
    
    /// Received from MapViewController.swift in form of AddAnnotation()
    var receivedAnnotation: AddAnnotation?
    
    @IBOutlet var pointTitle: UILabel!
    @IBOutlet var pointInfo: UILabel!
    
    /// Dismiss button, not needed since navigation is working
    @IBAction func dismissView(sender: AnyObject) {
        if self.navigationController != nil {
            navigationController?.popViewControllerAnimated(true)
        }
        else {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    /// Get Directions to Annotation Location
    @IBAction func getDirections(sender: AnyObject) {
        if let mainLatitude = receivedAnnotation?.coordinate.latitude, let mainLongitude = receivedAnnotation?.coordinate.longitude, let mainName = receivedAnnotation?.title {
            let localLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(mainLatitude, mainLongitude)
            let placemark = MKPlacemark(coordinate: localLocation, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            
            mapItem.name = mainName
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMapsWithLaunchOptions(launchOptions)
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
    
        UIConfig() // Configures the UI with the Itenwired Colors
        
        if let annotationName = receivedAnnotation?.title, let annotationInfo = receivedAnnotation?.info {
            pointTitle.text = annotationName
            pointInfo.text = annotationInfo
        }
        
    }
    
    internal func UIConfig(){
        self.view.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.pointTitle.textColor = ItenWiredStyle.text.color.mainColor
        self.pointInfo.textColor = ItenWiredStyle.text.color.mainColor
        self.navigationController?.navigationBarHidden = false 
    }
}
