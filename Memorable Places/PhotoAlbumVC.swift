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
        

    }
    
    override func viewWillAppear(animated: Bool) {
        
        // For debugging
        // Works!
        let flotsam = NSUserDefaults.standardUserDefaults().valueForKey(latitudeKey) as? Double
        print("\n\nHere is flotsam: \(flotsam)")
        
        //TODO: Persist the map's location
        
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
