//
//  BestTeamScreen.swift
//  MHSStats
//
//  Created by Ryan on 5/20/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit

public class BestTeamScreen: UIMethods {
    
    var width: Double?
    var height: Double?
    var x: Double?
    var y: Double?
    var records: Array<Array<Array<Record>>>?
    var coverScreen: UIView?

    public init(x: Double, y: Double, width: Double, height: Double, records: Array<Array<Array<Record>>>?) {
        self.width = width
        self.height = height
        self.x = x
        self.y = y
        self.records = records
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        self.backgroundColor = UIColor.clearColor()
        self.genCoverScreen()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func drawRect(rect: CGRect) {
        self.drawCenteredTextInRect(0, y: 0, width: CGFloat(width!), height: CGFloat(height!/2), toDraw: "Best Team:", fontSize: 20)
        self.drawCenteredTextInRect(0, y: CGFloat(height!/2), width: CGFloat(width!), height: CGFloat(height!/2), toDraw: getBestTeamInCurrentYear(), fontSize: 14)
    }
    
    func getBestTeamInCurrentYear() -> String {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Year, fromDate: date)
        var year = 0;
        year = components.year - 1
        var bestTeamID = 0
        var greatestSum = 0
        for i in 0 ..< records!.count {
            var sum = 0
            for x in 0 ..< records![i].count {
                for z in 0 ..< records![i][x].count {
                    if(records![i][x][z].year == Double(year)) {
                        sum += 1
                    }
                }
            }
            if sum > greatestSum {
                greatestSum = sum
                bestTeamID = i
            }
        }
        if(greatestSum == 0) {
            return "Boys Cross Country"
        }
        return records![bestTeamID][0][0].teamName
    }
    
    func genCoverScreen() {
        coverScreen = UIView(frame: CGRect(x: 0, y: 0, width: width!, height: height!))
        coverScreen?.backgroundColor = UIColor.whiteColor()
        self.addSubview(coverScreen!)
    }
    
    func displayBestTeam(speed: Double) {
        let xPosition = self.coverScreen!.frame.origin.x
        let yPosition = self.coverScreen!.frame.origin.y
        UIView.animateWithDuration(speed, animations: {
            self.coverScreen!.frame = CGRectMake(xPosition, yPosition, 0, 0)
        })
    }

    
}