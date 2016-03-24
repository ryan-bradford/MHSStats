
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
    var visible: Bool?
    
    init(x : Int, y : Int, width : Int, height : Int, records : Array<Record>, superScreen: ScreenDisplay) {
        let neededHeight = (Double(height) * 0.1 * Double((Int(records.count) + 1)))
        super.init(frame: CGRect(x: x, y: y, width: width, height: height), superScreen: superScreen)
        self.contentSize = (CGSizeMake(CGFloat(width), CGFloat(neededHeight)))
        self.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        self.addTeams(records, screenWidth : width, screenHeight : height)
        self.backgroundColor = UIColor(red: (1), green: 1, blue: (1), alpha: (1))
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addTeams(records : Array<Record>, screenWidth : Int, screenHeight : Int) {
        for i in 0 ..< records.count {
            let currentButton = RecordButton(x: 0, y: Int(Double(screenHeight) * 0.1 * Double(i)), width: screenWidth, height: Int(Double(screenHeight) * 0.1), record: records[Int(i)])
            buttons.append(currentButton)
            self.addSubview(buttons[(i)])
        }
    }
    
    func setVisible() {
        visible = true
    }
    
}