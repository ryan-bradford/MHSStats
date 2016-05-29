//
//  NewRecordButton.swift
//  MHSStats
//
//  Created by Ryan on 4/6/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit

public class NewRecordButton: MyButton {
    
    var circle = CAShapeLayer()
    var diameter: Double
    var screen: ScreenDisplay?
    var record: Record?
    
    init(x: Double, y: Double, screen: ScreenDisplay, record: Record) {
        self.screen = screen
        self.record = record
        self.diameter = FileStructure.newRecordsBarHeight - FileStructure.newRecordButtonGap
        super.init(frame: CGRect(x: x, y: y, width: diameter, height: diameter))
        self.drawCircle()
        self.addTarget(self, action: #selector(TeamButton.pressed(_:)), forControlEvents: UIControlEvents.TouchUpInside);
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.diameter = FileStructure.newRecordsBarHeight - FileStructure.newRecordButtonGap
        super.init(coder: aDecoder)
    }
    
    func drawCircle() {
        circle = CAShapeLayer()
        circle.opacity = 3
        circle.lineWidth = 1
        circle.strokeColor = FileStructure.MHSColor.CGColor
        circle.lineJoin = kCALineJoinMiter
        circle.fillColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: CGFloat(0.5)).CGColor
        let box = CGRectMake(0, 0, CGFloat(diameter), CGFloat(diameter))
        let ovalPath = UIBezierPath(ovalInRect : box)
        ovalPath.closePath()
        circle.path = ovalPath.CGPath
        self.layer.addSublayer(circle)
    }
    
    func drawText() {
        //print(self.record!.getQuickName())
        let textHeight = self.heightWithConstrainedWidth(self.frame.width, font: UIFont.boldSystemFontOfSize(25), toGet: self.record!.getQuickName())
        let standardHeight = self.heightWithConstrainedWidth(self.frame.width, font: UIFont.boldSystemFontOfSize(25), toGet: "H")
        if(textHeight > standardHeight) {
            let shiftDown = textHeight/2 - CGFloat(diameter) / 8
            self.drawCenteredTextInRect(0, y: shiftDown, width: CGFloat(diameter), height: CGFloat(diameter), toDraw: self.record!.getQuickName(), fontSize: 15)
        } else {
            let shiftDown = 1 * (textHeight/2 - CGFloat(diameter)) / 16
            self.drawCenteredTextInRect(0, y: shiftDown, width: CGFloat(diameter), height: CGFloat(diameter), toDraw: self.record!.getQuickName(), fontSize: 25)
        }
    }
    
    override public func drawRect(rect: CGRect) {
        self.drawText()
    }
    
    func pressed(sender: UIButton!) {
        screen!.transitionBackwards(1.0)
        screen!.transitionBackwards(1.0)
        screen!.transitionFromTeamsToCategories(Int(record!.teamName)!)
        screen!.transitionFromCategoriesToRecords(Int(record!.teamName)!, category: Int(record!.categoryName)!)
    }
    
}
