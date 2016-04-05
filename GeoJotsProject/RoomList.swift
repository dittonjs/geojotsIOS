//
//  RoomList.swift
//  GeoJotsProject
//
//  Created by Joseph Ditton on 4/2/16.
//  Copyright © 2016 Joseph Ditton. All rights reserved.
//

import UIKit
import Material

class RoomList {
    private var collectionView: MaterialCollectionView!

    func initialize(parentView: UIView, dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegate){
        collectionView = MaterialCollectionView(frame: CGRectMake(0, 70, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height - 70))
        collectionView.registerClass(RoomCell.self, forCellWithReuseIdentifier: "MaterialCollectionViewCell")
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate

        // Use MaterialLayout to easily align the tableView.
        parentView.addSubview(collectionView)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        MaterialLayout.alignToParent(parentView, child: collectionView)
    }
    
    func reload(){
        collectionView.reloadData()
        collectionView.frame = CGRectMake(0, 70, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height - 70)
    }
}




