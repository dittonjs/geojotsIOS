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
import Firebase
import GeoFire

class CreateController :UIViewController {

    private var mainNav = MainNavbar()
    private var cancelButton = CancelButton()
    private var titleTextField = TitleTextField()
    private var descriptionTextView = DescriptionTextView()
    private var createMessageBoardButton = CreateMessageBoardButton()
    private var mapView = GMSMapView()
    private var mapCamera = GMSCameraPosition.cameraWithLatitude(-33.86, longitude: 151.20, zoom: 15)
    private var mapMarker = GMSMarker()
    private var radiusMarker = GMSCircle()
    private var locationManager = CLLocationManager()
    private var radiusSlider = MaterialSlider()
    private var radius: CLLocationDistance = 50
    private var lastLocation: CLLocation = CLLocation()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        setUpGeolocation()
        
        mainNav.initialize(view)
        
        let startX: CGFloat = UIScreen.mainScreen().bounds.size.width - 15
        var startY: CGFloat = 107
        cancelButton.initialize(view, action: #selector(self.cancelCreation), startX: startX, startY: startY, parentRef: self)
        
        let top: CGFloat = 217
        let left: CGFloat = 30
        let bottom: CGFloat = UIScreen.mainScreen().bounds.size.height / 2
        let right: CGFloat = 30
        descriptionTextView.initialize(view, top: top, left: left, bottom: bottom, right: right)
        
        titleTextField.initialize(view, startX: 30, startY: 120)
        
        createMessageBoardButton.initialize(view, startX: 0, startY: UIScreen.mainScreen().bounds.size.height - 80, action: #selector(self.createLocation), parent: self)
        
        prepareMap()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        startY = UIScreen.mainScreen().bounds.size.height / 2 + 50
        let width = UIScreen.mainScreen().bounds.size.width - 60

        radiusSlider.initialize(view, startX: 30, startY: startY, width: width, height: 10, parent: self, action: #selector(self.onSlide))
    }
    
    func createLocation(){
        
        let roomRef = Firebase(url: "https://geojots.firebaseio.com/rooms")
        let locationRef = Firebase(url: "https://geojots.firebaseio.com/locations")
        let geoFire = GeoFire(firebaseRef: locationRef)
        
        let room = ["name": titleTextField.getValue(), "description": descriptionTextView.getValue()]
        roomRef.childByAutoId().setValue(room, withCompletionBlock: {
            (error: NSError!, ref: Firebase!) in
            print ("\(ref.key)")
            geoFire.setLocation(self.lastLocation, forKey: ref.key)
        })
    }
    
    func onSlide(sender: UISlider){
        let slider = sender as UISlider;
        radius = CLLocationDistance( 50 * trunc(slider.value * 100) + 50)
        radiusMarker.radius     = radius
        mapView.animateToZoom(15 - (50 * trunc(slider.value * 100) + 50)/1000)
        radiusMarker.map        = mapView
        
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
        let startY = UIScreen.mainScreen().bounds.size.height / 2 + 70
        mapView.frame = CGRectMake(0, startY, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height - startY - 80)
        mapView.camera = mapCamera
        mapView.settings.rotateGestures = false
        mapView.settings.scrollGestures = false
        mapView.settings.tiltGestures   = false
        mapView.delegate = self
        view.addSubview(mapView)
        
    }
    
}

extension CreateController: GMSMapViewDelegate {
    func mapView(mapView: GMSMapView, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        dismissKeyboard()
    }
}

extension CreateController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        lastLocation = manager.location!
        mapView.animateToLocation(locValue)
        mapMarker.position      = CLLocationCoordinate2DMake(locValue.latitude, locValue.longitude)
        mapMarker.map           = mapView
        radiusMarker.position   = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        radiusMarker.radius     = radius
        radiusMarker.map        = mapView
    }
}