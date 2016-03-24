//
//  TeamButton.swift
//  MHSStats
//
//  Created by Ryan on 3/8/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit

public class TeamButton : MyButton {
    
    public var teamName : String?
    var superScreen : TeamsScreen?
    var index : Int?
    
    public init(x : Int, y : Int, width : Int, height : Int, teamName : String, superScreen : TeamsScreen, index : Int) {
        self.teamName = teamName
        self.index = index
        self.superScreen = superScreen
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        self.addTarget(self, action: #selector(TeamButton.pressed(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)
        drawCenteredTextInRect(0, y: 0, width: self.frame.width, height: self.frame.height, toDraw: teamName!, fontSize: 25)
    }
    
    func pressed(sender: UIButton!) {
        superScreen!.pressedBy(index!)
    }    
    
}