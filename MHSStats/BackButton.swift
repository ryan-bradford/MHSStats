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
    var width: Int?
    var height: Int?
    var backButton: BackButton?

    public init(x : Int, y : Int, width : Int, height : Int, superScreen: ScreenDisplay) {
        self.superScreen = superScreen
        self.width = width
        self.height = height
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        self.addTarget(self, action: "pressed:", forControlEvents: UIControlEvents.TouchUpInside);
        
    }

    required public init(coder aDecoder: NSCoder) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    override public func drawRect(rect: CGRect) {
        self.drawCircle()
        self.drawLeftArrow()
    }
    
    func drawLeftArrow() {
        let leftArrowShape = CAShapeLayer()
        let arrowWidth = FileStructure.arrowWidth
        let arrowHeight = FileStructure.arrowHeight
        let middleWidth = 10
        self.layer.addSublayer(leftArrowShape)
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(CGFloat(0), CGFloat(0)))
        path.addLineToPoint(CGPointMake(CGFloat(arrowWidth/2), CGFloat(-arrowHeight / 2)))
        path.addLineToPoint(CGPointMake(CGFloat(arrowWidth/2), CGFloat(-middleWidth)))
        path.addLineToPoint(CGPointMake(CGFloat(arrowWidth), CGFloat(-middleWidth)))
        path.addLineToPoint(CGPointMake(CGFloat(arrowWidth), CGFloat(middleWidth)))
        path.addLineToPoint(CGPointMake(CGFloat(arrowWidth/2), CGFloat(middleWidth)))
        path.addLineToPoint(CGPointMake(CGFloat(arrowWidth/2), CGFloat(arrowHeight / 2)))
        path.closePath()
        leftArrowShape.path = path.CGPath
    }
    
    func drawCircle() {
        let circle = CAShapeLayer()
        let color = UIColor.grayColor().CGColor
        circle.fillColor = color
        let diameter = CGFloat(FileStructure.circleDiameter)
        self.layer.addSublayer(circle)
        let box = CGRectMake(-10, -diameter / 2, CGFloat(FileStructure.circleDiameter), CGFloat(FileStructure.circleDiameter))
        let ovalPath = UIBezierPath(ovalInRect : box)
        ovalPath.closePath()
        circle.path = ovalPath.CGPath
    }
    
    func pressed(sender: UIButton!) {
        superScreen!.transitionBackwards()
    }
    
}
