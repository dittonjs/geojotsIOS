//
//  CreateController.swift
//  GeoJotsProject
//
//  Created by Joseph Ditton on 4/4/16.
//  Copyright © 2016 Joseph Ditton. All rights reserved.
//

import Foundation
import UIKit
import Material
import Font_Awesome_Swift
import GoogleMaps

class CreateController :UIViewController {
    
    private var mainNav = MainNavbar()
    private var cancelButton = CancelButton()
    private var titleTextField = TitleTextField()
    private var descriptionTextView = DescriptionTextView()
    private var createMessageBoardButton = CreateMessageBoardButton()
    private var mapView = GMSMapView()
    private var mapCamera = GMSCameraPosition.cameraWithLatitude(-33.86, longitude: 151.20, zoom: 6)
    private var mapMarker = GMSMarker()
    private var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGeolocation()
        
        mainNav.initialize(view)
        
        let startX: CGFloat = UIScreen.mainScreen().bounds.size.width - 15
        let startY: CGFloat = 107
        cancelButton.initialize(view, action: #selector(self.cancelCreation), startX: startX, startY: startY, parentRef: self)
        
        let top: CGFloat = 217
        let left: CGFloat = 30
        let bottom: CGFloat = UIScreen.mainScreen().bounds.size.height / 2
        let right: CGFloat = 30
        descriptionTextView.initialize(view, top: top, left: left, bottom: bottom, right: right)
        
        titleTextField.initialize(view, startX: 30, startY: 120)
        
        createMessageBoardButton.initialize(view, startX: 0, startY: UIScreen.mainScreen().bounds.size.height - 80)
        
        prepareMap()
    }
    
    func cancelCreation(){
        print("return to root")
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func setUpGeolocation(){
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func prepareMap(){
        let startY = UIScreen.mainScreen().bounds.size.height / 2 + 50
        mapView.frame = CGRectMake(0, startY, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height - startY - 80)
        mapView.camera = mapCamera
        mapView.settings.setAllGesturesEnabled(false)
        view.addSubview(mapView)
        
    }
    
}

extension CreateController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        mapView.animateToLocation(locValue)
        mapMarker.position = CLLocationCoordinate2DMake(locValue.latitude, locValue.longitude)
        mapMarker.map = mapView
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}