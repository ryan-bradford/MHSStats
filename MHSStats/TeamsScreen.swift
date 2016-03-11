//
//  TeamScreen.swift
//  MHSStats
//
//  Created by Ryan on 3/8/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit

public class TeamsScreen : MyScrollView {
    
    var buttons = Array<TeamButton>()
    
    init(x : Int, y : Int, width : Int, height : Int, records : Array<Array<Array<Record>>>, superScreen : ScreenDisplay) {
        super.init(frame: CGRect(x: x, y: y, width: width, height: height), superScreen: superScreen)
        self.superScreen = superScreen
        let neededHeight = Int((Double(height) * 0.1 * Double((records.count + 1))))
        self.contentSize = (CGSizeMake(CGFloat(width), CGFloat(neededHeight)))
        self.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        self.addTeams(records, screenWidth : width, screenHeight : height)
        self.backgroundColor = UIColor(red: (1), green: 1, blue: (1), alpha: (1))
    }

    required public init(coder aDecoder: NSCoder) {
        super.init(frame: CGRect(x: 1, y: 1, width: 1, height: 1))
    }
    
    func addTeams(records : Array<Array<Array<Record>>>, screenWidth : Int, screenHeight : Int) {
        for var i = 0.0; i < Double(records.count); i++ {
            let currentButton = TeamButton(x: 0, y: Int(Double(screenHeight) * 0.1 * i), width: screenWidth, height: Int(Double(screenHeight) * 0.1), teamName: records[Int(i)][0][0].teamName, superScreen : self, index : Int(i))
            buttons.append(currentButton)
            self.addSubview(buttons[Int(i)])
        }
    }
    
    func pressedBy(categoryIndex : Int) {
        superScreen!.transitionFromTeamsToCategories(categoryIndex)
    }
    
    override public func drawRect(rect: CGRect) {
        
    }
    
}