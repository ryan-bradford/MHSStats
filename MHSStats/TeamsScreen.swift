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
    var visible: Bool?
    var newRecordsBar: NewRecordsBar?

    init(x : Int, y : Int, width : Int, height : Int, records : Array<Array<Array<Record>>>, superScreen : ScreenDisplay) {
        super.init(frame: CGRect(x: x, y: y, width: width, height: height), superScreen: superScreen)
        self.superScreen = superScreen
        self.newRecordsBar = NewRecordsBar(screenWidth: width, newRecords: superScreen.newRecords!, screen:superScreen)
        self.addSubview(self.newRecordsBar!)
        self.newRecordsBar!.alpha = 0.0
        let neededHeight = Int((Double(height) * 0.1 * Double((records.count + 2)))) + FileStructure.newRecordsBarHeight
        self.contentSize = (CGSizeMake(CGFloat(width), CGFloat(neededHeight)))
        self.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        self.addTeams(records, screenWidth : width, screenHeight : height)
        self.backgroundColor = UIColor(red: (1), green: 1, blue: (1), alpha: (1))
    }

    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addTeams(records : Array<Array<Array<Record>>>, screenWidth : Int, screenHeight : Int) {
        for i in 0 ..< records.count {
            let currentButton = TeamButton(x: 0, y: FileStructure.newRecordsBarHeight +  Int(Double((screenHeight)) * 0.1 * Double(i)), width: screenWidth, height: Int(Double(screenHeight) * 0.1), teamName: records[Int(i)][0][0].teamName, superScreen : self, index : Int(i))
            buttons.append(currentButton)
            self.addSubview(buttons[Int(i)])
        }
    }
    
    func pressedBy(categoryIndex : Int) {
        if(visible!) {
            superScreen!.transitionFromTeamsToCategories(categoryIndex)
        }
        visible = false
    }
    
    override public func drawRect(rect: CGRect) {
        
    }
    
    func setVisible() {
        visible = true
    }
    
}