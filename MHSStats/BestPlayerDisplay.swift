//
//  BestPlayerDisplay.swift
//  MHSStats
//
//  Created by Ryan on 5/20/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit

public class BestPlayerDisplay: UIMethods {
    
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
        self.drawCenteredTextInRect(0, y: 0, width: CGFloat(width!), height: CGFloat(height!/2), toDraw: "Best Player:", fontSize: 20)
        self.drawCenteredTextInRect(0, y: CGFloat(height!/2), width: CGFloat(width!), height: CGFloat(height!/2), toDraw: String(getBestPlayer()), fontSize: 14)
    }
    
    func getBestPlayer() -> String {
        
        var allNames = Array<String>()
        for var teams in records! {
            for var cat in teams {
                for var record in cat {
                    if(record.personName.containsString("_")) {
                        let parts = record.personName.characters.split{$0 == "_"}.map(String.init)
                        for var x in parts {
                            allNames.append(x)
                        }
                    } else if(record.personName != "The Creators") {
                        allNames.append(record.personName)
                    }
                }
            }
        }
        var singleNames = Array<String>()
        for var x in allNames {
            if(!singleNames.contains(x)) {
                singleNames.append(x)
            }
        }
        var totals = Array<Int>()
        for x in 0 ..< singleNames.count {
            totals.append(x)
        }
        for x in 0 ..< singleNames.count {
            for var name in allNames {
                if(name == singleNames[x]) {
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
        return singleNames[Int(biggestID)]
        
    }
    
    
    
}