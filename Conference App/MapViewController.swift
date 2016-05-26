        //
//  MapViewController.swift
//  Conference App
//
//  Created by Julian L on 4/8/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    // Outlets for Map, and Segment Result
    @IBOutlet weak var segmentResult: UISegmentedControl!
    @IBOutlet weak var mainMap: MKMapView!
    @IBOutlet weak var segmentStyle: UISegmentedControl!
   // @IBOutlet weak var menuButtonMap: UIButton!
    

    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    var destination: MKMapItem?
    
    // Pulls Map Data
    var mapController: MapData = MapData()
    var locArray: [Location] = []
    var annotationArray: [AddAnnotation] = []
    
    // Coordinates for Center Location
    var latSum:Double = 0.00
    var longSum:Double = 0.00
    
    // Fallback incase JSON does not load
    var mainLatitude: CLLocationDegrees = 30.331991 // Need to get from JSON
    var mainLongitude: CLLocationDegrees = -87.136002 // Need to get from JSON
    
    @IBAction func openDirections(sender: AnyObject) {
        
        // Segmented Control on the Bottom of Screen (iTenWired, My Location, & Directions)
        switch sender.selectedSegmentIndex
        {
        case 0:
            // Show All Map Annotations
            let newCoords = CLLocationCoordinate2D(latitude: CLLocationDegrees(latSum), longitude: CLLocationDegrees(longSum))
            let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            let newRegion:MKCoordinateRegion = MKCoordinateRegion(center:newCoords, span:span )
            
            self.mainMap.setRegion(newRegion, animated: true)
            
        case 1:
            
            // Show User's Location on the Map
            self.mainMap.showsUserLocation = true;
            
            let latDelta:CLLocationDegrees = 0.04
            let lonDelta:CLLocationDegrees = 0.04
            
            // If lat & long are available, center map on location
            if let latitude:CLLocationDegrees = locationManager.location?.coordinate.latitude {
                if let longitude:CLLocationDegrees = locationManager.location?.coordinate.longitude {
                    let userLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                    let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
                    let region:MKCoordinateRegion = MKCoordinateRegionMake(userLocation, span)
                    mainMap.setRegion(region, animated: false)
                }
            }
            
        default:
            break;
        }
        
    }
    
    @IBAction func menuButtonAction(sender: AnyObject) {
        if let splitController = self.splitViewController{
            if !splitController.collapsed {
                splitController.toggleMasterView()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let splitController = self.splitViewController{
//            if !splitController.collapsed {
//              //  self.menuButtonMap.hidden = false
//            }
//        }
        
        segmentStyle.layer.cornerRadius = 5
        
        // Setup the Map and Location Manager
        self.locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        self.mainMap.delegate = self
        startLocation = nil
        
        // Retrieves locations from MapData and loaded into locArray
        for locs in mapController.conferenceLocations {
            locArray.append(locs)
        }
        
        if (annotationArray.count == 0) {
            addNotations()
        }
        
        if let splitController = self.splitViewController{
            splitController.toggleMasterView()
        }
        
    }
    
    // Adds the Info Button to all of the Annotations
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "LocationAnnotation"
        
        if annotation.isKindOfClass(AddAnnotation.self) {
            if let annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) {
                annotationView.annotation = annotation
                return annotationView
            } else {
                let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
                annotationView.enabled = true
                annotationView.canShowCallout = true
                
                let btn = UIButton(type: .DetailDisclosure)
                annotationView.rightCalloutAccessoryView = btn
                return annotationView
            }
        }
        
        return nil
    }
    
    // Object that Selected Map Annotation will be Stored In
    var selectedAnnotation: AddAnnotation!
    
    // Called when Annotation Info Button is Selected
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            
            if let tempName = view.annotation?.title, let tempLat = view.annotation?.coordinate.latitude, let tempLong = view.annotation?.coordinate.longitude, let tempSub = view.annotation?.subtitle {
                
                let tempCoord = CLLocationCoordinate2D(latitude: tempLat, longitude: tempLong)
                
                selectedAnnotation = AddAnnotation(title: tempName!, coordinate: tempCoord, info: tempSub!)
                
            }
            //selectedAnnotation = view.annotation as? MKPointAnnotation
            
            // Launches AnnotationDetailViewController
            performSegueWithIdentifier("NextScene", sender: self)
        }
        
        
    }
    
    // Preparing to segue to AnnotationDetailViewController and sending the selected annotation data with it
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? AnnotationDetailViewController {
            destination.receivedAnnotation = selectedAnnotation
        }
    }
    
    // This is called when viewDidLoad() and sets up all of the annotations on the map
    func addNotations() {
        
        // Centers Map on Main Location (Called on Launch)
        var count = 0.00
        
        // All locations "loc" are stored in this array and converted into annotations
        for locs in locArray {
            if let tempLat = CLLocationDegrees(locs.latitude), let tempLong = CLLocationDegrees(locs.longitude), let tempName:String = locs.name, let tempDesc:String = locs.description {
            
                let tempCoord = CLLocationCoordinate2D(latitude: CLLocationDegrees(tempLat), longitude: CLLocationDegrees(tempLong))
                latSum += Double(tempLat)
                longSum += Double(tempLong)
                let tempAnnotation = AddAnnotation(title: tempName, coordinate: tempCoord, info: tempDesc)
                
                annotationArray.append(tempAnnotation)
                count += 1
            }
            
        }
        
        // Add annotations to the map
        if !(annotationArray.isEmpty) {
            self.mainMap.addAnnotations(annotationArray)
            
            // Gets the average coordinates to center the map region on
            latSum = latSum/count
            longSum = longSum/count
            
            // Centers the map based on average of locations
            let newCoords = CLLocationCoordinate2D(latitude: CLLocationDegrees(latSum), longitude: CLLocationDegrees(longSum))
            let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            let newRegion:MKCoordinateRegion = MKCoordinateRegion(center:newCoords, span:span )
            
            self.mainMap.setRegion(newRegion, animated: true)
            self.mainMap.showsUserLocation = true;
            
        }
        else {
            
            // Presents an error message saying "No Internet Connection"
            let noInternet = UIAlertController(title: "Internet Connection", message: "Map cannot be loaded because there is no internet connection.", preferredStyle: UIAlertControllerStyle.Alert)
            
            noInternet.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in
                print("Handle Ok logic here")
            }))
            
            presentViewController(noInternet, animated: true, completion: nil)
            latSum = mainLatitude
            longSum = mainLongitude
            
            let newCoords = CLLocationCoordinate2D(latitude: CLLocationDegrees(latSum), longitude: CLLocationDegrees(longSum))
            let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            let newRegion:MKCoordinateRegion = MKCoordinateRegion(center:newCoords, span:span )
            
            self.mainMap.setRegion(newRegion, animated: true)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var locationStatus : NSString = "Not Started"
    // authorization status
    
    func locationManager(manager: CLLocationManager,
                         didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        var shouldIAllow = false
        
        switch status {
        case CLAuthorizationStatus.Restricted:
            locationStatus = "Restricted Access to location"
        case CLAuthorizationStatus.Denied:
            locationStatus = "User denied access to location"
        case CLAuthorizationStatus.NotDetermined:
            locationStatus = "Status not determined"
        default:
            locationStatus = "Allowed to location Access"
            shouldIAllow = true
        }
        NSNotificationCenter.defaultCenter().postNotificationName("LabelHasbeenUpdated", object: nil)
        if (shouldIAllow == true) {
            NSLog("Location to Allowed")
            // Start location services
            locationManager.startUpdatingLocation()
        } else {
            NSLog("Denied access: \(locationStatus)")
        }
        
    }
    

    
    
    @IBAction func showMenu(sender: AnyObject) {
        if let splitController = self.splitViewController{
            
            if !splitController.collapsed {
                splitController.toggleMasterView()
                
            } else{
                let rightNavController = splitViewController!.viewControllers.first as! UINavigationController
                rightNavController.popToRootViewControllerAnimated(true)
            }
        }
    
    }
}

