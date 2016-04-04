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
    private var createRoomBtn: FabButton = FabButton(frame: CGRectMake(0, 0 ,75,75))
    
    
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
        createButton()
        prepareView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func prepareView() {
        view.backgroundColor = MaterialColor.white
        view.grid.axis.direction = .None
        view.grid.views = [createRoomBtn]
        view.grid.axis.columns = 4
        view.grid.axis.rows = 15
        view.grid.spacingPreset = MaterialSpacing.Spacing3
        view.grid.contentInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 10, right: 10)
        
    }
    
    func createButton(){
        
        var imageSize = CGSize()
        imageSize.width = 30
        imageSize.height = 30
        let image: UIImage? = UIImage(icon: FAType.FAPlus, size: imageSize, textColor: MaterialColor.white, backgroundColor: GeoJotsTheme.salmon)
        createRoomBtn.setImage(image, forState: .Normal)
        createRoomBtn.setImage(image, forState: .Highlighted)
        createRoomBtn.grid.rows = 2
        createRoomBtn.grid.columns = 1
        createRoomBtn.grid.offset.rows = 13
        createRoomBtn.grid.offset.columns = 3
        createRoomBtn.layer.zPosition = 10
        createRoomBtn.backgroundColor = GeoJotsTheme.salmon
        view.addSubview(createRoomBtn)
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


