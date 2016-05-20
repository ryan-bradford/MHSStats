
//
//  TeamScreen.swift
//  MHSStats
//
//  Created by Ryan on 3/8/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit

public class RecordsScreen : MyScrollView {
    
    var buttons = Array<RecordButton>()
    var totalHeight = 0.0
    
    init(x : Double, y : Double, width : Double, height : Double, records : Array<Record>, superScreen: ScreenDisplay) {
        super.init(frame: CGRect(x: x, y: y, width: width, height: height), superScreen: superScreen)
        self.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        self.addTeams(records, screenWidth : width, screenHeight : height)
        let neededHeight = totalHeight + Double(FileStructure.topBarHeight)
        self.contentSize = (CGSizeMake(CGFloat(width), CGFloat(neededHeight)))
        self.backgroundColor = UIColor(red: (1), green: 1, blue: (1), alpha: (1))
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addTeams(records : Array<Record>, screenWidth : Double, screenHeight : Double) {
        for i in 0 ..< records.count {
            let currentButton = RecordButton(x: 0, y: Double(totalHeight), width: screenWidth, record: records[Int(i)], screenHeight: Double(screenHeight))
            totalHeight += currentButton.height!
            buttons.append(currentButton)
            self.addSubview(buttons[(i)])
        }
    }
    
    func setVisible() {
        visible = true
    }
    
}