//
//  MapViewController.swift
//  TempConverter
//
//  Created by Raditia Madya on 5/28/17.
//  Copyright © 2017 Universitas Gadjah Mada. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func loadView() {
        //create a map view
        mapView = MKMapView()
        
        view = mapView
        
        let segmentControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentControl)
        
        let margins = view.layoutMarginsGuide
        let topConstraint = segmentControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        let leadingConstraint = segmentControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    
    func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        case 3:
            zoomLocation()
        default:
            break
        }
    }
    
    func zoomLocation() {
        print("locations = \(self.mapView.userLocation.coordinate.longitude) ")
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.mapView.userLocation.coordinate.latitude, self.mapView.userLocation.coordinate.longitude)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, MKCoordinateSpanMake(0.5, 0.5))
        print("zooming")
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        var locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    //Delegate if Authorization Status has Changed
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus){
        locationManager.startUpdatingLocation()
    }
    
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!){
        let coord = userLocation.coordinate
        print("delegate: coord = \(coord.longitude)")
    }
    
    func mapViewDidFinishLoadingMap(mapView: MKMapView!){
        print("finished loading mapview")
        self.mapView.showsUserLocation = true
        
        print("Is User Location Visible: \(self.mapView.isUserLocationVisible)")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        mapView.showsUserLocation = true
        print("Is User Location Visible: \(mapView.userLocation.location?.coordinate.latitude)")
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            print("Authorization Status = \(CLLocationManager.authorizationStatus() == .authorizedWhenInUse)")
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            locationManager.delegate = self
        }
        else{
            print("location services disabled")
        }
    }
    
}

// TODO: Dropping pins
