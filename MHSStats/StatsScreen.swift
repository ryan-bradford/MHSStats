//
//  StatsScreen.swift
//  MHSStats
//
//  Created by Ryan on 4/29/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit
 //Build Grid of 150x150 boxes for module stats
public class StatsScreen : MyScrollView {
    
    var records: Array<Array<Array<Record>>>?
    var boxHeight: Double?
    var boxWidth: Double?
    var height: Double?
    var width: Double?
    let boxHeightCount = 3.0
    let boxWidthCount = 2.0
    var recordsGraph: RecordsGraph?
    var bestTeamScreen: BestTeamScreen?
    var bestYearScreen: BestYearScreen?
    var bestPlayerScreen: BestPlayerScreen?
    var bestTypeScreen: BestTypeDisplay?
    var stuffShown = false
    var toDrawGraph = true
    
    init(x : Double, y: Double, screenWidth: Double, screenHeight: Double, records : Array<Array<Array<Record>>>) {
        self.records = records
        self.height = screenHeight
        self.width = screenWidth
        super.init(frame: CGRect(x: x, y: y, width: screenWidth, height: screenHeight))
        self.backgroundColor = UIColor(red: (1), green: 1, blue: (1), alpha: (1))
    }
    
    override public func drawRect(rect: CGRect) {
        boxWidth = width! / boxWidthCount
        boxHeight = (height!-FileStructure.topBarHeight) / boxHeightCount
        //drawBoxes()
        displayStats()
    }
    
    func drawBoxes() {
        FileStructure.MHSColor.set()
        var path: UIBezierPath
        for i in 0 ..< Int(boxHeightCount) + 1 {
            path = UIBezierPath()
            path.moveToPoint(CGPoint(x: 0, y: Double(i) * boxHeight! + 3))
            path.addLineToPoint(CGPoint(x: width!, y: Double(i) * boxHeight!+3))
            path.lineWidth = 5
            path.stroke()
        }
        for i in 0 ..< Int(boxWidthCount) + 1 {
            path = UIBezierPath()
            path.moveToPoint(CGPoint(x: Double(i)*boxWidth!, y: 3))
            if(i == 1 && toDrawGraph) {
                path.moveToPoint(CGPoint(x: Double(i)*boxWidth!, y: boxHeight! + 3))
            }
            path.addLineToPoint(CGPoint(x: Double(i)*boxWidth!, y: height! + 3))
            path.lineWidth = 5
            path.stroke()
        }
    }
    
    func displayStats() {
        if(toDrawGraph) {
            recordsGraph = RecordsGraph(x: -5 + 3 * width!/16, y: 5, width: width! / boxWidthCount + width!/8, height: boxHeight!, records: records!)
            self.addSubview(recordsGraph!)
        }
            
        bestTeamScreen = BestTeamScreen(x: 3, y: boxHeight! + 5, width: boxWidth! - 5, height: boxHeight! - 5, records: records!)
        self.addSubview(bestTeamScreen!)
        
        bestYearScreen = BestYearScreen(x: 3 + boxWidth!, y: boxHeight! + 5, width: boxWidth! - 5, height: boxHeight! - 5, records: records!)
        self.addSubview(bestYearScreen!)
        
        bestPlayerScreen = BestPlayerScreen(x: 3, y: 2 * boxHeight! + 10, width: boxWidth! - 5, height: boxHeight! - 5, records: records!)
        self.addSubview(bestPlayerScreen!)
        
        bestTypeScreen = BestTypeDisplay(x: 3 + boxWidth!, y: 2 * boxHeight! + 10, width: boxWidth! - 5, height: boxHeight! - 5, records: records!)
        self.addSubview(bestTypeScreen!)
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func showDisplay() {
        if(!stuffShown) {
            stuffShown = true
            recordsGraph!.displayGraph(1)
            bestTeamScreen!.displayBestTeam(1)
            bestPlayerScreen!.displayBestTeam(1)
            bestYearScreen!.displayBestTeam(1)
        }
    }
    
}