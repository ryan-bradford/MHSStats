//
//  TeamButton.swift
//  MHSStats
//
//  Created by Ryan on 3/8/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit

public class RecordButton : MyButton {
    
    public var record : Record?
    
    public init(x : Int, y : Int, width : Int, height : Int, record : Record) {
        self.record = record
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        self.addTarget(self, action: #selector(RecordButton.pressed(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)
        var pushDown = drawCenteredTextInRect(0, y: 0, width: self.frame.width, height: self.frame.height / 2, toDraw: record!.eventName, fontSize: 20)
        drawCenteredTextInRect(0, y: pushDown - 2, width: self.frame.width / 2, height: 8 * self.frame.height / 24, toDraw: record!.personName, fontSize: 15)
        var shiftSideways = self.frame.width / 2
        var widthToDrawIn = self.frame.width / 2
        if(record!.personName == " ") {
            shiftSideways = 0
            widthToDrawIn = self.frame.width
        }
        pushDown += drawCenteredTextInRect(shiftSideways, y: pushDown - 2, width: widthToDrawIn, height: 8 * self.frame.height / 24, toDraw: record!.mainData + ": " + record!.dataUnits, fontSize: 15)
        drawCenteredTextInRect(0, y: pushDown - 5, width: self.frame.width, height: 8 * self.frame.height / 24, toDraw: String(record!.year), fontSize: 15)
    }
    
    func pressed(sender: UIButton!) {
        
    }
    
    
}