//
//  roomCell.swift
//  GeoJotsProject
//
//  Created by Joseph Ditton on 4/2/16.
//  Copyright © 2016 Joseph Ditton. All rights reserved.
//

import Foundation
import Material
import Font_Awesome_Swift

class RoomCell :MaterialCollectionViewCell {
    
    func load(title: String, index: Int) {
        self.pulseColor = MaterialColor.cyan.base
        self.pulseScale = false
        self.borderWidthPreset = MaterialBorder.Border1
        self.borderColor = MaterialColor.grey.lighten1
        
        let circleColors = [
            GeoJotsTheme.blue,
            GeoJotsTheme.yellow,
            GeoJotsTheme.green,
            GeoJotsTheme.red
        ]

        let letterCircle = MaterialView(frame: CGRectMake(0, 0 ,48,48))
        letterCircle.shape = .Circle
        letterCircle.grid.columns = 2
        letterCircle.grid.rows = 8
        letterCircle.grid.offset.rows = 2
        letterCircle.grid.offset.columns = 1
        letterCircle.backgroundColor = circleColors[index % 4]
        
        let letterLabel = UILabel()
        letterLabel.text = title[0]
        letterLabel.textColor = MaterialColor.white
        letterLabel.font = RobotoFont.boldWithSize(25)
        letterLabel.textAlignment = .Center
        letterCircle.addSubview(letterLabel)
        letterCircle.grid.views = [letterLabel]
        
        let membersLabel = UILabel()
        membersLabel.setFAText(prefixText: "", icon: FAType.FAUser, postfixText: " 17", size: 15)
        membersLabel.textColor = MaterialColor.grey.lighten1
        membersLabel.grid.offset.columns = 3
        membersLabel.grid.rows = 4
        membersLabel.grid.offset.rows = 6
        membersLabel.grid.columns = 2
        
        let distanceLabel = UILabel()
        distanceLabel.setFAText(prefixText: "", icon: FAType.FAMapMarker, postfixText: " 28m", size: 15)
        distanceLabel.textColor = MaterialColor.grey.lighten1
        distanceLabel.grid.offset.columns = 5
        distanceLabel.grid.rows = 4
        distanceLabel.grid.offset.rows = 6
        distanceLabel.grid.columns = 2
        
        let cellTitleLabel = UILabel()
        cellTitleLabel.text = title
        cellTitleLabel.grid.offset.columns = 3
        cellTitleLabel.grid.rows = 4
        cellTitleLabel.grid.offset.rows = 2
        cellTitleLabel.grid.columns = 7
        cellTitleLabel.font = RobotoFont.boldWithSize(17)
        
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        
        self.contentView.addSubview(letterCircle)
        self.contentView.addSubview(cellTitleLabel)
        self.contentView.addSubview(membersLabel)
        self.contentView.addSubview(distanceLabel)
        self.contentView.grid.axis.direction = .None
        self.contentView.grid.spacingPreset = MaterialSpacing.Spacing3
        self.contentView.grid.views = [letterCircle, cellTitleLabel, membersLabel, distanceLabel]
    }
}