//
//  AnnotationDetailViewController.swift
//  Conference App
//
//  Created by Julian L on 4/13/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AnnotationDetailViewController: UIViewController {
    
    // Received from MapViewController.swift in form of AddAnnotation()
    var receivedAnnotation: AddAnnotation?
    
    @IBOutlet var pointTitle: UILabel!
    @IBOutlet var pointInfo: UILabel!
    
    // Dismiss button, not needed since navigation is working
    @IBAction func dismissView(sender: AnyObject) {
        if self.navigationController != nil {
            navigationController?.popViewControllerAnimated(true)
        }
        else {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    // Get Directions to Annotation Location
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
    
        self.UIConfig()
        
        if let annotationName = receivedAnnotation?.title, let annotationInfo = receivedAnnotation?.info {
            pointTitle.text = annotationName
            pointInfo.text = annotationInfo
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func UIConfig(){
        self.view.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.pointTitle.textColor = ItenWiredStyle.text.color.mainColor
        self.pointInfo.textColor = ItenWiredStyle.text.color.mainColor
        self.navigationController?.navigationBarHidden = false 
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
