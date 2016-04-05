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

class ViewController: UIViewController {
    private var mainNav: MainNavbar = MainNavbar()
    private var roomList: RoomList = RoomList()
    private var createRoomBtn: CreateRoomButton = CreateRoomButton()
    
    
//    hard coded for now
    private var dataSourceItems = [
        MaterialDataSourceItem(data: ["title": "Atomic Jolt"], height: 80),
        MaterialDataSourceItem(data: ["title": "Instructurecon Chat"], height: 80),
        MaterialDataSourceItem(data: ["title": "Hack USU"], height: 80),
        MaterialDataSourceItem(data: ["title": "Panopen Hack"], height: 80),
        MaterialDataSourceItem(data: ["title": "OER Discussion"], height: 80),
        MaterialDataSourceItem(data: ["title": "Atomic Jolt"], height: 80),
        MaterialDataSourceItem(data: ["title": "Instructurecon Chat"], height: 80),
        MaterialDataSourceItem(data: ["title": "Hack USU"], height: 80),
        MaterialDataSourceItem(data: ["title": "Panopen Hack"], height: 80),
        MaterialDataSourceItem(data: ["title": "OER Discussion"], height: 80),
        MaterialDataSourceItem(data: ["title": "Atomic Jolt"], height: 80),
        MaterialDataSourceItem(data: ["title": "Instructurecon Chat"], height: 80),
        MaterialDataSourceItem(data: ["title": "Hack USU"], height: 80),
        MaterialDataSourceItem(data: ["title": "Panopen Hack"], height: 80),
        MaterialDataSourceItem(data: ["title": "OER Discussion"], height: 80),
        MaterialDataSourceItem(data: ["title": "OER Discussion"], height: 80),
        MaterialDataSourceItem(data: ["title": "Atomic Jolt"], height: 80),
        MaterialDataSourceItem(data: ["title": "Instructurecon Chat"], height: 80),
        MaterialDataSourceItem(data: ["title": "Hack USU"], height: 80),
        MaterialDataSourceItem(data: ["title": "Panopen Hack"], height: 80),
        MaterialDataSourceItem(data: ["title": "OER Discussion"], height: 80),
        MaterialDataSourceItem(data: ["title": "OER Discussion"], height: 80),
        MaterialDataSourceItem(data: ["title": "Atomic Jolt"], height: 80),
        MaterialDataSourceItem(data: ["title": "Instructurecon Chat"], height: 80),
        MaterialDataSourceItem(data: ["title": "Hack USU"], height: 80),
        MaterialDataSourceItem(data: ["title": "Panopen Hack"], height: 80),
        MaterialDataSourceItem(data: ["title": "OER Discussion"], height: 80)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        mainNav.initialize(view)
        roomList.initialize(view, dataSource: self, delegate: self)
        
        let startX: CGFloat = UIScreen.mainScreen().bounds.size.width - 15
        let startY: CGFloat = UIScreen.mainScreen().bounds.size.height - 15
        createRoomBtn.initialize(view, action: #selector(self.transitionToCreateRoom), startX: startX, startY: startY, parentRef: self)
        prepareView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func prepareView() {
        view.backgroundColor = MaterialColor.white
    }
    
    
    func transitionToCreateRoom(sender: UIButton!){
        self.performSegueWithIdentifier("create", sender: sender)
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

extension ViewController :MaterialCollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("asdfasdfa")
    }
}

extension ViewController :MaterialCollectionViewDataSource {
    
    func items() -> Array<MaterialDataSourceItem> {
        return dataSourceItems
    }
    
    /// Determines the number of items in the collectionView.
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceItems.count;
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
            cell.load(data["title"] as! String, index: indexPath.item)
        }
        
        return cell
    }
}


