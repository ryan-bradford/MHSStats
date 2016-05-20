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
    var teamID : Double?
    var categoryID : Double?
    
    public init(x : Double, y : Double, width : Double, height : Double, categoryName : String, superScreen: CategoryScreen, teamID : Double, categoryID : Double) {
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