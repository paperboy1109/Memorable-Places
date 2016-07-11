//
//  PhotoAlbumVC.swift
//  Memorable Places
//
//  Created by Daniel J Janiak on 7/11/16.
//  Copyright © 2016 Daniel J Janiak. All rights reserved.
//

import UIKit
import MapKit

class PhotoAlbumVC: UIViewController {
    
    // MARK: - Properties
    
    let latitudeKey = "Latitude Key"
    let longitudeKey = "Longitude Key"
    let latitudeDeltaKey = "Latitude Delta Key"
    let longitudeDeltaKey = "Longitude Delta Key"
    let previousUseKey = "App Prior Launch Key"
    
    // MARK: - Outlets    
    @IBOutlet var map: MKMapView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\n\n view did load")
        
        setMapRegion()
        
        map.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        
        print("\n\n view will appear")
        
        // For debugging
        // Works!
        let flotsam = NSUserDefaults.standardUserDefaults().valueForKey(latitudeKey) as? Double
        print("\n\nHere is flotsam: \(flotsam)")
        
    }
    
    // MARK: - Helpers
    func setMapRegion() {
        
        // Set up the map
        
        let startingLatitude = NSUserDefaults.standardUserDefaults().valueForKey(latitudeKey) as? Double
        let startingLongitude = NSUserDefaults.standardUserDefaults().valueForKey(longitudeKey) as? Double
        let coordinate = CLLocationCoordinate2DMake(startingLatitude!, startingLongitude!)
        
        let latDelta:CLLocationDegrees = NSUserDefaults.standardUserDefaults().valueForKey(latitudeDeltaKey) as! Double //0.01
        let lonDelta:CLLocationDegrees = NSUserDefaults.standardUserDefaults().valueForKey(longitudeDeltaKey) as! Double //0.01
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
        
        self.map.setRegion(region, animated: true)
        
    }
    
    
    
    
    

}


extension PhotoAlbumVC: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "TravelLocation"
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
        
        if annotationView == nil {
            
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            
            let annotationBtn = UIButton(type: .DetailDisclosure)
            annotationView!.rightCalloutAccessoryView = annotationBtn
            
        } else {
            
            annotationView!.annotation = annotation
        }
        
        return annotationView
        
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        /* For debugging only
         // What came with the annotationView?
         print("\n *** calloutAccessoryControlTapped has been called *** ")
         //print(self.studentInfo.first)
         
         // Found it!
         print(view.annotation?.subtitle)
         */
        
        print("calloutAccessoryControlTapped called")

    }
    
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("\nMap view region changed, saving new position\n")
        let currentRegion = mapView.region
        print("Here is currentRegion: \(currentRegion)")
        print("Here is currentRegion.center: \(currentRegion.center)")
        print("Here is currentRegion.span: \(currentRegion.span)")
        
        NSUserDefaults.standardUserDefaults().setValue(Double(currentRegion.center.latitude), forKey: latitudeKey)
        NSUserDefaults.standardUserDefaults().setValue(Double(currentRegion.center.longitude), forKey: longitudeKey)
        NSUserDefaults.standardUserDefaults().setValue(Double(currentRegion.span.latitudeDelta), forKey: latitudeDeltaKey)
        NSUserDefaults.standardUserDefaults().setValue(Double(currentRegion.span.longitudeDelta), forKey: longitudeDeltaKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        let flotsam = NSUserDefaults.standardUserDefaults().valueForKey(latitudeKey) as? Double
        print("\n\nHere is the value for latitudeKey: \(flotsam)")
    }
    
    
}
