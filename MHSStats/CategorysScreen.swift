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
    var teamID : Int?
    
    public init(x : Int, y : Int, width : Int, height : Int, records : Array<Array<Record>>, teamID : Int, superScreen : ScreenDisplay) {
        super.init(frame: CGRect(x: x, y: y, width: width, height: height), superScreen: superScreen)
        var neededHeight = Int((Double(height) * 0.1 * Double((records.count + 1))))
        self.contentSize = (CGSizeMake(CGFloat(width), CGFloat(neededHeight)))
        self.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        self.teamID = teamID
        self.addCategories(records, screenWidth : width, screenHeight : height)
        self.superScreen = superScreen
        self.backgroundColor = UIColor(red: (1), green: 1, blue: (1), alpha: (1))
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(frame: CGRect(x: 1, y: 1, width: 1, height: 1))
    }
    
    func addCategories(records : Array<Array<Record>>, screenWidth : Int, screenHeight : Int) {
        for var i = 0.0; i < Double(records.count); i++ {
            let currentButton = CategoryButton(x: 0, y: Int(Double(screenHeight) * 0.1 * i), width: screenWidth, height: Int(Double(screenHeight) * 0.1), categoryName: records[Int(i)][0].categoryName, superScreen: self, teamID: teamID!, categoryID: Int(i))
            buttons.append(currentButton)
            self.addSubview(buttons[Int(i)])
        }
    }
    
    func pressedBy(teamID : Int, categoryID : Int) {
        superScreen!.transitionFromCategoriesToRecords(teamID, category: categoryID)
    }
    
}