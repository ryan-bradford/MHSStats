//
//  MostRecordsDisplauy.swift
//  MHSStats
//
//  Created by Ryan on 5/20/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit

public class MostRecordsDisplay: UIMethods {
 
    var records: Array<Array<Array<Record>>>?
    var x: Double?
    var y: Double?
    var width: Double?
    var height: Double?
    
    init(x: Double, y: Double, width: Double, height: Double, records: Array<Array<Array<Record>>>){
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        self.records = records
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.backgroundColor = UIColor.clearColor()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func drawRect(rect: CGRect) {
        self.drawCenteredTextInRect(0, y: 0, width: CGFloat(width!), height: CGFloat(height!/2), toDraw: "Best Year:", fontSize: 20)
        self.drawCenteredTextInRect(0, y: CGFloat(height!/2), width: CGFloat(width!), height: CGFloat(height!/2), toDraw: String(getBestYear()), fontSize: 14)
    }
    
    func getBestYear() -> Int {
        var yearTotals = Array<Int>()
        for _ in 0 ..< 3000 {
            yearTotals.append(0)
        }
        for var teams in records! {
            for var cat in teams {
                for var record in cat {
                    yearTotals[Int(record.year)] += 1
                }
            }
        }
        var biggestID = 0
        for i in 0 ..< yearTotals.count {
            if(yearTotals[i] > yearTotals[biggestID]) {
                biggestID = i
            }
        }
        return biggestID
    }
    
    
 }