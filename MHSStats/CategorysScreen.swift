//
//  TeamScreen.swift
//  MHSStats
//
//  Created by Ryan on 3/8/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit

public class CategoryScreen : MyScrollView {
    
    var buttons = Array<CategoryButton>()
    var teamID : Double?

    public init(x : Double, y : Double, width : Double, height : Double, records : Array<Array<Record>>, teamID : Double, superScreen : ScreenDisplay) {
        super.init(frame: CGRect(x: x, y: y, width: width, height: height), superScreen: superScreen)
        let neededHeight = (((height) * 0.1 * ((Double(records.count) + 2.0))))
        self.contentSize = (CGSizeMake(CGFloat(width), CGFloat(neededHeight)))
        self.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        self.teamID = teamID
        self.addCategories(records, screenWidth : width, screenHeight : height)
        self.superScreen = superScreen
        self.backgroundColor = UIColor(red: (1), green: 1, blue: (1), alpha: (1))
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addCategories(records : Array<Array<Record>>, screenWidth : Double, screenHeight : Double) {
        for i in 0 ..< records.count - 1 {
            let currentButton = CategoryButton(x: 0, y: screenHeight * 0.1 * Double(i), width: screenWidth, height: screenHeight * 0.1, categoryName: records[Int(i)][0].categoryName, superScreen: self, teamID: teamID!, categoryID: Double(i))
            buttons.append(currentButton)
            self.addSubview(buttons[Int(i)])
        }
    }
    
    func pressedBy(teamID : Double, categoryID : Double) {
        if(visible!) {
            superScreen!.transitionFromCategoriesToRecords(Int(teamID), category: Int(categoryID))
        }
        visible = false
    }
    
    func setVisible() {
        visible = true
    }
    
}