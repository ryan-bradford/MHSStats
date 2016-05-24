//
//  BestPlayerDisplay.swift
//  MHSStats
//
//  Created by Ryan on 5/20/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit

public class BestTypeDisplay: UIMethods {
    
    var records: Array<Array<Array<Record>>>?
    var x: Double?
    var y: Double?
    var width: Double?
    var height: Double?
    var coverScreen: UIView?

    init(x: Double, y: Double, width: Double, height: Double, records: Array<Array<Array<Record>>>){
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        self.records = records
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.backgroundColor = UIColor.clearColor()
        //self.genCoverScreen()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func drawRect(rect: CGRect) {
        self.drawCenteredTextInRect(0, y: 0, width: CGFloat(width!), height: CGFloat(height!/2), toDraw: "Best Type of Event:", fontSize: 20)
        self.drawCenteredTextInRect(0, y: CGFloat(height!/2), width: CGFloat(width!), height: CGFloat(height!/2), toDraw: String(getBestType()), fontSize: 14)
    }
    
    func getBestType() -> String {
        
        var allTypes = Array<String>()
        for var teams in records! {
            for var cat in teams {
                for var record in cat {
                    if(record.categoryName != "Championship") {
                        allTypes.append(record.categoryName)
                    }
                }
            }
        }
        var singleTypes = Array<String>()
        for var x in allTypes {
            if(!singleTypes.contains(x)) {
                singleTypes.append(x)
            }
        }
        var totals = Array<Int>()
        for x in 0 ..< singleTypes.count {
            totals.append(x)
        }
        for x in 0 ..< singleTypes.count {
            for var type in allTypes {
                if(type == singleTypes[x]) {
                    totals[x] += 1
                }
            }
        }
        var biggestID = 0
        for x in 0 ..< totals.count {
            if totals[x] > totals[biggestID] {
                biggestID = x
            }
        }
        return singleTypes[Int(biggestID)]
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