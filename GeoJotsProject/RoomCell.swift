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
        
        // colors for dots
        let circleColors = [
            GeoJotsTheme.blue,
            GeoJotsTheme.yellow,
            GeoJotsTheme.green,
            GeoJotsTheme.red
        ]
        
        // the dot
        let letterCircle = MaterialView(frame: CGRectMake(15, 15, 45, 45))
        letterCircle.shape = .Circle
        letterCircle.backgroundColor = circleColors[index % 4]
        
        let letterLabel = UILabel()
        letterLabel.text = title[0]
        letterLabel.textColor = MaterialColor.white
        letterLabel.font = RobotoFont.boldWithSize(25)
        letterLabel.textAlignment = .Center
        letterCircle.addSubview(letterLabel)
        letterCircle.grid.views = [letterLabel]
        
        // the content
        let contentWidth = UIScreen.mainScreen().bounds.size.width - 90
        let contentContainer = MaterialView(frame: CGRectMake(75, 15, contentWidth, 45))
        contentContainer.grid.axis.direction = .None

        let membersLabel = UILabel()
        membersLabel.setFAText(prefixText: "", icon: FAType.FAUser, postfixText: " 17", size: 15)
        membersLabel.textColor = MaterialColor.grey.lighten1
        membersLabel.grid.rows = 6
        membersLabel.grid.offset.rows = 6
        membersLabel.grid.columns = 2
        
        let distanceLabel = UILabel()
        distanceLabel.setFAText(prefixText: "", icon: FAType.FAMapMarker, postfixText: " 28m", size: 15)
        distanceLabel.textColor = MaterialColor.grey.lighten1
        distanceLabel.grid.offset.columns = 2
        distanceLabel.grid.rows = 6
        distanceLabel.grid.offset.rows = 6
        distanceLabel.grid.columns = 2
        
        let cellTitleLabel = UILabel()
        cellTitleLabel.text = title
        cellTitleLabel.grid.rows = 6
        cellTitleLabel.grid.columns = 12
        cellTitleLabel.font = RobotoFont.boldWithSize(17)
        
        // add content to content view
        contentContainer.addSubview(cellTitleLabel)
        contentContainer.addSubview(distanceLabel)
        contentContainer.addSubview(membersLabel)
        contentContainer.grid.views = [cellTitleLabel, membersLabel, distanceLabel]
        
        // remove subviews
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        } // this is hacky i should look for a better solution for this.
        
        // add content
        self.contentView.addSubview(letterCircle)
        self.contentView.addSubview(contentContainer)
    }
}