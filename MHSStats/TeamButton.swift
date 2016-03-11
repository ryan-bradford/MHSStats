//
//  TeamButton.swift
//  MHSStats
//
//  Created by Ryan on 3/8/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit

public class TeamButton : UIButton {
    
    public var teamName : String?
    var superScreen : TeamsScreen?
    var index : Int?
    
    public init(x : Int, y : Int, width : Int, height : Int, teamName : String, superScreen : TeamsScreen, index : Int) {
        self.teamName = teamName
        self.index = index
        self.superScreen = superScreen
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        self.addTarget(self, action: "pressed:", forControlEvents: UIControlEvents.TouchUpInside);

    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(frame: CGRect(x: 1, y: 1, width: 1, height: 1))
        self.addTarget(self, action: "pressed:", forControlEvents: UIControlEvents.TouchUpInside);
    }
    
    override public func drawRect(rect: CGRect) {
        let message1  = teamName
        let message: NSMutableAttributedString = NSMutableAttributedString(string: message1!)
        
        let fieldColor: UIColor = UIColor.blackColor()
        let fieldFont = UIFont(name: "Helvetica Neue", size: CGFloat(25))
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.alignment = NSTextAlignment.Center
        paraStyle.lineSpacing = 6.0
        let skew = 0.1
        //message.addAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(25)], range: NSRange(location: 5, length: 2))
        
        let attributes: NSDictionary = [
            NSForegroundColorAttributeName: fieldColor,
            NSParagraphStyleAttributeName: paraStyle,
            NSObliquenessAttributeName: skew,
            NSFontAttributeName: fieldFont!
        ]
        let countString = (message.length)
        message.addAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(25)], range: NSRange(location: 0, length: countString))
        message.addAttributes(attributes as! [String : AnyObject], range: NSRange(location: 0, length: countString) )
        message.drawInRect(CGRectMake(0.0, 0.0, 300.0, 60.0))
    }
    
    func pressed(sender: UIButton!) {
        superScreen!.pressedBy(index!)
    }
    
    
}