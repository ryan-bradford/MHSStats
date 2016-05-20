//
//  BackButton.swift
//  MHSStats
//
//  Created by Ryan on 3/10/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit

public class BackButton : UIButton {
    
    var superScreen: ScreenDisplay?
    var width: Double?
    var height: Double?
    var backButton: BackButton?
    var circleDiameter: Double?

    public init(x : Double, y : Double, width : Double, height : Double, superScreen: ScreenDisplay) {
        self.superScreen = superScreen
        self.width = width
        self.height = height
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        self.addTarget(self, action: #selector(BackButton.pressed(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override public func drawRect(rect: CGRect) {
        self.drawRedCircle()
        self.drawGreyCircle()
        self.drawLeftArrow()
    }
    
    func drawLeftArrow() {
        let leftArrowShape = CAShapeLayer()
        let arrowWidth = FileStructure.arrowWidth
        let arrowHeight = FileStructure.arrowHeight
        let middleWidth = FileStructure.arrowMiddleWidth
        self.layer.addSublayer(leftArrowShape)
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(CGFloat(13), CGFloat(FileStructure.circleDiameter / 2)))
        path.addLineToPoint(CGPointMake(CGFloat(arrowWidth/2 + 13), CGFloat(-arrowHeight / 2 + FileStructure.circleDiameter / 2)))
        path.addLineToPoint(CGPointMake(CGFloat(arrowWidth/2 + 13), CGFloat(-middleWidth / 2 + FileStructure.circleDiameter / 2)))
        path.addLineToPoint(CGPointMake(CGFloat(arrowWidth + 13), CGFloat(-middleWidth / 2 + FileStructure.circleDiameter / 2)))
        path.addLineToPoint(CGPointMake(CGFloat(arrowWidth + 13), CGFloat(middleWidth / 2 + FileStructure.circleDiameter / 2)))
        path.addLineToPoint(CGPointMake(CGFloat(arrowWidth/2 + 13), CGFloat(middleWidth / 2 + FileStructure.circleDiameter / 2)))
        path.addLineToPoint(CGPointMake(CGFloat(arrowWidth/2 + 13), CGFloat(arrowHeight / 2 + FileStructure.circleDiameter / 2)))
        path.closePath()
        leftArrowShape.path = path.CGPath
    }
    
    func drawGreyCircle() {
        let circle = CAShapeLayer()
        let color = UIColor.grayColor().CGColor
        circle.fillColor = color
        self.layer.addSublayer(circle)
        let box = CGRectMake(3, CGFloat(3), CGFloat(FileStructure.circleDiameter), CGFloat(FileStructure.circleDiameter))
        let ovalPath = UIBezierPath(ovalInRect : box)
        ovalPath.closePath()
        circle.path = ovalPath.CGPath
    }
    
    func drawRedCircle() {
        let circle = CAShapeLayer()
        let color = FileStructure.MHSColor.CGColor
        circle.fillColor = color
        self.layer.addSublayer(circle)
        let box = CGRectMake(0, CGFloat(0), CGFloat(FileStructure.circleDiameter + 6), CGFloat(FileStructure.circleDiameter + 6))
        let ovalPath = UIBezierPath(ovalInRect : box)
        ovalPath.closePath()
        circle.path = ovalPath.CGPath
    }
    
    func pressed(sender: UIButton!) {
        superScreen!.transitionBackwards(1.0)
    }
    
}
