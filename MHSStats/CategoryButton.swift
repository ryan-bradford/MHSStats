//
//  TeamButton.swift
//  MHSStats
//
//  Created by Ryan on 3/8/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit

public class CategoryButton : MyButton {
    
    public var categoryName : String?
    var superScreen : CategoryScreen?
    var teamID : Int?
    var categoryID : Int?
    
    public init(x : Int, y : Int, width : Int, height : Int, categoryName : String, superScreen: CategoryScreen, teamID : Int, categoryID : Int) {
        self.categoryName = categoryName
        self.superScreen = superScreen
        self.teamID = teamID
        self.categoryID = categoryID
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        self.addTarget(self, action: #selector(CategoryButton.pressed(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)
        drawCenteredTextInRect(0, y: 0, width: self.frame.width, height: self.frame.height, toDraw: categoryName!, fontSize: 25)
    }
    
    func pressed(sender: UIButton!) {
        superScreen!.pressedBy(teamID!, categoryID: categoryID!)
    }
    
    
}