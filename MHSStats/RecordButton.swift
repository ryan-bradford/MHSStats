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
    public var height: Double?
    var screenHeight: Double?
    
    public init(x : Int, y : Int, width : Int, record : Record, screenHeight: Double) {
        self.record = record
        self.screenHeight = screenHeight
        let myHeight = (CGFloat(Double(screenHeight) * 0.1))
        super.init(frame: CGRect(x: x, y: y, width: width, height: Int(myHeight)))
        height = drawText()
        self.frame = CGRect(x: x, y: y, width: width, height: Int(height!))
        self.addTarget(self, action: #selector(RecordButton.pressed(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)
        drawText()
    }
    
    func drawText() -> Double {
        var pushDown = drawTextWithNoBox(0, y: 0, width: self.frame.width, toDraw: record!.eventName, fontSize: 20)
        let heightOfLast = drawTextWithNoBox(0, y: pushDown, width: self.frame.width / 2, toDraw: record!.personName, fontSize: 15)
        var shiftSideways = self.frame.width / 2
        var widthToDrawIn = self.frame.width / 2
        if(record!.personName == " ") {
            shiftSideways = 0
            widthToDrawIn = self.frame.width
        }
        drawCenteredTextInRect(shiftSideways, y: pushDown, width: widthToDrawIn, height: heightOfLast, toDraw: record!.mainData + ": " + record!.dataUnits, fontSize: 15)
        pushDown += heightOfLast
        pushDown += drawTextWithNoBox(0, y: pushDown, width: self.frame.width, toDraw: String(record!.year), fontSize: 15)
        return Double(pushDown)
    }
    
    func pressed(sender: UIButton!) {
        
    }
    
    
}