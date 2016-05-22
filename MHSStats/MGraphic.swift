//
//  MGraphic.swift
//  MHSStats
//
//  Created by Ryan on 3/11/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit

public class MGraphic : UIView {
    
    var horMovingPane: UIView?
    var vertMovingPane: UIView?
    var mPoints: Array<Array<Double>>?
    var count = 0
    
    public init(screenWidth: Double, y: Double, mDraw: Bool) {
        mPoints = Array<Array<Double>>()
        mPoints?.append(Array<Double>())
        mPoints?.append(Array<Double>())
        var height = 0.0
        var width = 0.0
        while(height > -FileStructure.mHeight) {
            height -= sin(1.0 * M_PI / 2.0) * 1.0
            width += cos(1.0 * M_PI / 2.0) * 1.0
            mPoints![0].append((width))
            mPoints![1].append((height))
        }
        while(height < -20) {
            height += sin(M_PI / 3) * 1.0
            width += cos(M_PI / 3) * 1.0
            mPoints![0].append((width))
            mPoints![1].append((height))
        }
        
        while(height > -FileStructure.mHeight) {
            height -= sin(M_PI / 3) * 1.0
            width += cos(M_PI / 3) * 1.0
            mPoints![0].append((width))
            mPoints![1].append((height))
        }
        while(height < 0) {
            height += sin(1.0 * M_PI / 2.0) * 1.0
            width += cos(1.0 * M_PI / 2.0) * 1.0
            mPoints![0].append((width))
            mPoints![1].append((height))
        }
        let myWidth = mPoints![0][mPoints![0].count - 1]
        let realWidth = Double(Double(myWidth) + FileStructure.mLineWidth + 5)
        let halfScreenWidth = Double(screenWidth / 2)
        let halfWidth = Double(realWidth) / 2.0
        super.init(frame: CGRect(x: (halfScreenWidth - halfWidth), y: y, width: (realWidth), height: (FileStructure.mHeight)))
        if(mDraw) {
            self.initPanes((realWidth), height: (FileStructure.mHeight))
        }
        self.backgroundColor = UIColor.clearColor()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    override public func drawRect(rect: CGRect) {
        self.drawM()
    }
    
    func drawM() {
        while(count < mPoints![0].count) {
            drawNextLine()
        }
    }
    
    func initPanes(width: Double, height: Double) {
        horMovingPane = UIView(frame: CGRect(x: (FileStructure.mLineWidth), y: 0, width: width, height: height))
        horMovingPane!.backgroundColor = UIColor.whiteColor()
        self.addSubview(horMovingPane!)
        vertMovingPane = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        vertMovingPane!.backgroundColor = UIColor.whiteColor()
        self.addSubview(vertMovingPane!)
    }
    
    func showM(viewController: ViewController, screen: ScreenDisplay) {
        slideVertUpPart1(viewController, screen: screen)
    }
    
    func slideVertUpPart1(viewController: ViewController, screen: ScreenDisplay) {
        let xVertPosition = vertMovingPane!.frame.origin.x
        let yVertPosition = vertMovingPane!.frame.origin.y - self.frame.size.height
        
        let vertHeight = vertMovingPane!.frame.size.height
        let vertWidth = vertMovingPane!.frame.size.width
        
        UIView.animateWithDuration(0.5 * FileStructure.introScale, animations: {
            self.vertMovingPane!.frame = CGRectMake(xVertPosition, yVertPosition, vertWidth, vertHeight)
            }, completion: {
                (value: Bool) in
                self.slideHorSideWaysPart2(viewController, screen: screen)
                self.vertMovingPane!.frame = CGRectMake(self.vertMovingPane!.frame.origin.x + CGFloat(FileStructure.mWidth) + CGFloat(FileStructure.mLineWidth) - 2, 0, self.vertMovingPane!.frame.size.width, self.vertMovingPane!.frame.size.height)
        })
    }
    
    func slideHorSideWaysPart2(viewController: ViewController, screen: ScreenDisplay) {
        let xHorPosition = horMovingPane!.frame.origin.x + CGFloat(self.frame.size.width)
        let yHorPosition = horMovingPane!.frame.origin.y
        
        let horHeight = horMovingPane!.frame.size.height
        let horWidth = horMovingPane!.frame.size.width
        
        UIView.animateWithDuration(1.0 * FileStructure.introScale, animations: {
            self.horMovingPane!.frame = CGRectMake(xHorPosition - 2.5 * CGFloat(FileStructure.mLineWidth), yHorPosition, horWidth, horHeight)
        }, completion: {
                (value: Bool) in
                self.horMovingPane!.removeFromSuperview()
                self.slideVertDownPart3(viewController, screen: screen)
        })
    }
    
    func slideVertDownPart3(viewController: ViewController, screen: ScreenDisplay) {
        let xVertPosition = vertMovingPane!.frame.origin.x
        let yVertPosition = vertMovingPane!.frame.origin.y + self.frame.size.height
        
        let vertHeight = vertMovingPane!.frame.size.height
        let vertWidth = vertMovingPane!.frame.size.width
        
        UIView.animateWithDuration(0.5 * FileStructure.introScale, animations: {
            self.vertMovingPane!.frame = CGRectMake(xVertPosition, yVertPosition, vertWidth, vertHeight)
            }, completion: {
                (value: Bool) in
                 self.vertMovingPane!.removeFromSuperview()
                viewController.initStage2(screen)
        })
    }
    
    func drawNextLine() {
        let yOffset = FileStructure.mHeight
        let xOffset = 10.0
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(CGFloat(mPoints![0][count] + (xOffset)), CGFloat(mPoints![1][count] + (yOffset))))
        path.addLineToPoint(CGPointMake(CGFloat(mPoints![0][count] - (FileStructure.mLineWidth) + (xOffset)), CGFloat(mPoints![1][count] + (yOffset))))
        path.closePath()
        FileStructure.MHSColor.set()
        path.stroke()
        self.count += 1
    }
    
}