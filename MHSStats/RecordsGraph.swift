//
//  RecordsGraph.swift
//  MHSStats
//
//  Created by Ryan on 5/19/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit

public class RecordsGraph: UIMethods {
    
    var records: Array<Array<Array<Record>>>?
    var width: Double?
    var height: Double?
    var horTextSpace = (20.0)
    var vertTextSpace = (36.0)
    var yRanges: Array<Double>?
    var xRanges: Array<Double>?
    var coverScreen: UIView?
    
    public init(x: Double, y: Double, width: Double, height: Double, records: Array<Array<Array<Record>>>) {
        self.records = records
        self.width = Double(width) - Double(horTextSpace)
        self.height = Double(height) - 2 * Double(vertTextSpace)
        super.init(frame: CGRect(x: x, y: y, width: width + horTextSpace, height: height + 2 * vertTextSpace))
        self.backgroundColor = UIColor.clearColor()
        //self.alpha = 0.0
        //self.genCoverScreen()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func drawRect(rect: CGRect) {
        self.genGraph(width!, height: height!)
        (self.drawTextWithNoBox(-CGFloat(width!/2) + (3 * CGFloat(horTextSpace) / 2), y: CGFloat(height!) + (5 * CGFloat(vertTextSpace) / 4), width: CGFloat(width!), toDraw: String(Int(xRanges![1])), fontSize: 12))
        (self.drawTextWithNoBox(CGFloat(width!/2), y: CGFloat(height!) + (5 * CGFloat(vertTextSpace) / 4), width: CGFloat(width!), toDraw: String(Int(xRanges![0])), fontSize: 12))
        (self.drawTextWithNoBox((-CGFloat(width!/2)) + CGFloat(horTextSpace / 2), y: (CGFloat(vertTextSpace)), width: CGFloat(width!), toDraw: String(Int(yRanges![0])), fontSize: 12))
        (self.drawTextWithNoBox((-CGFloat(width!/2)) + CGFloat(horTextSpace / 2), y: CGFloat(height!) + (3 * CGFloat(vertTextSpace) / 4), width: CGFloat(width!), toDraw: String(Int(yRanges![1])), fontSize: 12))
        self.drawTextWithNoBox(CGFloat(horTextSpace), y: (0), width: CGFloat(width!), toDraw: "Championships vs Time Graph", fontSize: 14)
    }
    
    
      
    func genGraph(width: Double, height: Double) {
        
        var data = genGraphData()
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Year, fromDate: date)
        if(data.count == 2) {
            data = Array<Double>(arrayLiteral: 0.0, data[0], Double(components.year))
        }
        
        let endYear = components.year
        let startYear = data[data.count - 1]
        var xScale = Double(width)
        if(Double(endYear) != startYear) {
            xScale = Double(width / Double((Double(endYear) - startYear)))
        }
        xRanges = Array<Double>(arrayLiteral: Double(endYear), startYear, (xScale))
        
        yRanges = getGraphRange(data)
        let biggestY = getGraphRange(data)[0]
        let leastY = getGraphRange(data)[1]
        let range = biggestY - leastY
        let yScale = height / Double(range)
        
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(CGFloat(horTextSpace), (CGFloat(height) - CGFloat(data[0]) * CGFloat(yScale)) + CGFloat(vertTextSpace)))
        for i in 1 ..< data.count - 1 {
            path.addLineToPoint(CGPointMake((CGFloat(horTextSpace) + (CGFloat(i) * CGFloat(xScale))), (CGFloat(height) - CGFloat(data[i]) * CGFloat(yScale)) + CGFloat(vertTextSpace)))
        }
        path.lineWidth = 3
        FileStructure.MHSColor.set()
        path.stroke()
    }
    
    func genCoverScreen() {
        coverScreen = UIView(frame: CGRect(x: horTextSpace - 1, y: vertTextSpace - 1, width: width! + 2, height: height! + 3))
        coverScreen?.backgroundColor = UIColor.whiteColor()
        self.addSubview(coverScreen!)
    }
    
    func getGraphRange(data: Array<Double>) -> Array<Double> {
        var toReturn = Array<Double>()
        var biggest = 0.0
        for x in 0 ..< data.count - 1 {
            if data[x] > biggest {
                biggest = data[x]
            }
        }
        toReturn.append(biggest)
        var smallest = 1000000000.0
        for x in 0 ..< data.count - 1 {
            if data[x] < smallest {
                smallest = data[x]
            }
        }
        toReturn.append(smallest)
        return toReturn
    }

    
    func genGraphData() -> Array<Double> {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Year, fromDate: date)
        let year = Double(components.year)
        var points = Array<Double>()
        var leastYear = Double(year)
        for i in 0 ..< records!.count {
            for x in 0 ..< records![i].count {
                for z in 0 ..< records![i][x].count {
                    if records![i][x][z].year < leastYear {
                        leastYear = records![i][x][z].year
                    }
                }
            }
        }
        var range = year - leastYear
        if(range > FileStructure.acceptableGraphRange) {
            leastYear = year - FileStructure.acceptableGraphRange
            range = FileStructure.acceptableGraphRange
        }
        for _ in 0 ..< Int(range + 1) {
            points.append(0)
        }
        points.append(leastYear)
        for i in 0 ..< records!.count {
            if records![i][0][0].categoryName == "Championships" {
                for x in 0 ..< records![i].count {
                    for z in 0 ..< records![i][x].count {
                        if(records![i][x][z].year > leastYear) {
                            points[Int(records![i][x][z].year - leastYear)] += 1
                        }
                    }
                }
            }
        }
        return points
    }
    
    public func displayGraph(speed: Double) {
        let xPosition = self.coverScreen!.frame.origin.x
        let yPosition = self.coverScreen!.frame.origin.y
        UIView.animateWithDuration(speed, animations: {
            self.coverScreen!.frame = CGRectMake(xPosition, yPosition, 0, 0)
        })
    }

    
}