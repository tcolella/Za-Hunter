//
//  ViewController.swift
//  Za' Hunter
//
//  Created by Tommy Colella on 2/24/20.
//  Copyright © 2020 Tommy Colella. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    var region = MKCoordinateRegion()
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        func mapViewDidFinishLoadingMap()
        {
            let request = MKLocalSearch.Request()
                request.naturalLanguageQuery = "pizza"
                request.region = region
                let search = MKLocalSearch(request: request)
                search.start { (response, error) in
                   if let response = response {
                      for mapItem in response.mapItems {
                         print(mapItem.name!)
                      }
                   }
                }
        }
        
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.first!
        let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
        region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
    }
}


