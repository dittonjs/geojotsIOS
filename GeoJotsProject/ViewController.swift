//
//  ViewController.swift
//  GeoJotsProject
//
//  Created by Joseph Ditton on 4/2/16.
//  Copyright © 2016 Joseph Ditton. All rights reserved.
//

import UIKit
import Material
import Font_Awesome_Swift
import Firebase
import GeoFire
import GoogleMaps

class ViewController: UIViewController {
    private var mainNav: MainNavbar = MainNavbar()
    private var roomList: RoomList = RoomList()
    private var createRoomBtn: AddButton = AddButton()
    private var locationManager = CLLocationManager()
    private var needsUpdate     = true
    private var mapView: GMSMapView?;
    private var mapCamera = GMSCameraPosition.cameraWithLatitude(-33.86, longitude: 151.20, zoom: 15)
    private var mapMarker = GMSMarker()
    private var radiusMarker = GMSCircle()
    private var radius: CLLocationDistance = 50
    private var lastLocation: CLLocation = CLLocation()
    private var radiusSlider = MaterialSlider()
    var userId = "";
//    hard coded for now
    private var dataSourceItems: [MaterialDataSourceItem] = [

    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VIEW DID LOADs")
        // Read data and react to changes
       
        mainNav.initialize(view)
        roomList.initialize(view, dataSource: self, delegate: self)
        
        let startX: CGFloat = UIScreen.mainScreen().bounds.size.width - 15
        let startY: CGFloat = UIScreen.mainScreen().bounds.size.height - 15
        createRoomBtn.initialize(view, action: #selector(self.transitionToCreateRoom), startX: startX, startY: startY, parentRef: self)
        setUpGeolocation()
        prepareView()
        prepareMap()
        
        let width = UIScreen.mainScreen().bounds.size.width - 30
        radiusSlider.initialize(view, startX: 15, startY: 205, width: width, height: 10, parent: self, action: #selector(self.onSlide))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        //needsUpdate = true
        
    }
    
    func prepareView() {
        view.backgroundColor = MaterialColor.white
    }
    
    func onSlide(sender: UISlider){
        let slider = sender as UISlider;
        radius = CLLocationDistance( 50 * trunc(slider.value * 100) + 50)
        radiusMarker.radius     = radius
        mapView!.animateToZoom(15 - (50 * trunc(slider.value * 100) + 50)/1000)
        radiusMarker.map        = mapView
        
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
        mapView = GMSMapView()
        mapView!.frame = CGRectMake(0, 70, UIScreen.mainScreen().bounds.size.width, 140)
        mapView!.camera = mapCamera
        mapView!.settings.rotateGestures = false
        mapView!.settings.scrollGestures = false
        mapView!.settings.tiltGestures   = false
        view.addSubview(mapView!)
        
    }
    
    func transitionToCreateRoom(sender: UIButton!){
//        self.performSegueWithIdentifier("create", sender: sender)
        let createController = CreateController()
        createController.userId = self.userId
        self.presentViewController(createController, animated: true, completion: nil)
        
        //self.navigationController!.pushViewController(createController, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "room" {
            // setup controller here
        }
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        print("orientation changed")
        createRoomBtn.updateRect(UIScreen.mainScreen().bounds.size.width - 15, startY: UIScreen.mainScreen().bounds.size.height - 15)
        roomList.reload()
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        lastLocation = manager.location!
        mapView!.animateToLocation(locValue)
        mapMarker.position      = CLLocationCoordinate2DMake(locValue.latitude, locValue.longitude)
        mapMarker.map           = mapView
        radiusMarker.position   = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        radiusMarker.radius     = radius
        radiusMarker.map        = mapView
        
        if(!needsUpdate) {
            return // dont do anything if you dont need an update
        }
        
        dataSourceItems = [] // clear out the list
        let locationRef = Firebase(url: "https://geojots.firebaseio.com/locations")
        let geoFire = GeoFire(firebaseRef: locationRef)
//        roomRef.observeEventType(.Value, withBlock: {
//            snapshot in
//            print("\(snapshot.key) -> \(snapshot.value)")
//        })
        let geoFireQuery = geoFire.queryAtLocation(manager.location, withRadius: 1)
        geoFireQuery.observeEventType(.KeyEntered, withBlock: {
            (key: String!, location: CLLocation!) in
            let ref = Firebase(url: "https://geojots.firebaseio.com/rooms/\(key)")
            ref.observeEventType(.Value, withBlock: {
                (snapshot: FDataSnapshot!) in
                let data = snapshot.value as! [String: String]
                self.dataSourceItems.append(MaterialDataSourceItem(data: data, height: 80))
                self.roomList.reload()
                print("\(snapshot.key) and \(snapshot.value)")
                
            })
        })
        needsUpdate = false
    }
}

extension ViewController :MaterialCollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let roomController = RoomController()
        navigationController?.pushViewController(roomController, animated: true)
    }
}

extension ViewController :MaterialCollectionViewDataSource {
    
    func items() -> Array<MaterialDataSourceItem> {
        return dataSourceItems
    }
    
    /// Determines the number of items in the collectionView.
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceItems.count
    }
    
    /// Returns the number of sections.
    func numberOfSectionsInCollectionView(tableView: UICollectionView) -> Int {
        return 1
    }
    
    /// Prepares the cells within the tableView.
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: RoomCell = collectionView.dequeueReusableCellWithReuseIdentifier("MaterialCollectionViewCell", forIndexPath: indexPath) as! RoomCell
        let item: MaterialDataSourceItem = dataSourceItems[indexPath.item]
        
        if let data: Dictionary<String, AnyObject> =  item.data as? Dictionary<String, AnyObject> {
            cell.load(data["name"] as! String, index: indexPath.item)
        }
        
        return cell
    }
}


