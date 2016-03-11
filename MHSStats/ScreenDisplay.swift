//
//  ScreenDisplay.swift
//  MHSStats
//
//  Created by Ryan on 3/9/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit

public class ScreenDisplay : UIView {
   
    var teamsScreen : TeamsScreen? //Screen That Displays the Teams
    var categoryScreens : Array<CategoryScreen>? //Screen That Displays the Categories for a Team
    var recordsScreens : Array<Array<RecordsScreen>>? //Screen That Displays the Records for a Category
    var records : Array<Array<Array<Record>>>?
    var screenWidth : Int?
    var topBar: TopBar?
    var teamIDDisplayed: Int?
    var categoryIDDisplayed: Int?

    public init(x : Int, y : Int, width : Int, height : Int) {
        let processor = TextProcessor()
        records = processor.records
        self.screenWidth = width
        categoryScreens = Array<CategoryScreen>()
        recordsScreens = Array<Array<RecordsScreen>>()
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        for var i = 0; i < records!.count; i++ {
            recordsScreens!.append(Array<RecordsScreen>())
            categoryScreens!.append(CategoryScreen(x: width, y: FileStructure.topBarHeight, width: width, height: height, records: records![i], teamID: i, superScreen: self))
            for var x = 0; x < records![i].count; x++ {
                recordsScreens![i].append(RecordsScreen(x: width, y: FileStructure.topBarHeight, width: width, height: height, records: records![i][x], superScreen: self))
            }
        }
        teamsScreen = TeamsScreen(x: 0, y: FileStructure.topBarHeight, width: width, height: height, records: records!, superScreen: self)
        self.addSubview(teamsScreen!)
        for var i = 0; i < recordsScreens!.count; i++ {
            self.addSubview(categoryScreens![i])
        }
        
        for var i = 0; i < recordsScreens!.count; i++ {
            for var x = 0; x < recordsScreens![i].count; x++ {
                self.addSubview(recordsScreens![i][x])
            }
        }
        topBar = TopBar(width: screenWidth!, superScreen: self)
        addSubview(topBar!)
    }

    public required init(coder aDecoder: NSCoder) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    func transitionFromTeamsToCategories(team : Int) {
        topBar?.slideOnBackButton()
        let xPosition = categoryScreens![team].frame.origin.x - CGFloat(screenWidth!)
        let yPosition = categoryScreens![team].frame.origin.y
        
        let height = categoryScreens![team].frame.size.height
        let width = categoryScreens![team].frame.size.width
        
        UIView.animateWithDuration(1.0, animations: {
            self.categoryScreens![team].frame = CGRectMake(xPosition, yPosition, width, height)
        })
        teamIDDisplayed = team

    }
    
    func transitionFromCategoriesToRecords(team : Int, category: Int) {
        let xPosition = recordsScreens![team][category].frame.origin.x - CGFloat(screenWidth!)
        let yPosition = recordsScreens![team][category].frame.origin.y
        
        let height = recordsScreens![team][category].frame.size.height
        let width = recordsScreens![team][category].frame.size.width
        
        UIView.animateWithDuration(1.0, animations: {
            self.recordsScreens![team][category].frame = CGRectMake(xPosition, yPosition, width, height)
        })
        
        teamIDDisplayed = team
        categoryIDDisplayed = category
    }
    
    func transitionBackwards() {
        var currentlyDisplayed: MyScrollView?
        if(teamIDDisplayed == nil && categoryIDDisplayed == nil) {
            return
        } else if(categoryIDDisplayed == nil) {
            topBar?.slideOffBackButton()
            currentlyDisplayed = categoryScreens![teamIDDisplayed!]
            teamIDDisplayed = nil
        } else {
            currentlyDisplayed = recordsScreens![teamIDDisplayed!][categoryIDDisplayed!]
            categoryIDDisplayed = nil
        }
        let xPosition = currentlyDisplayed!.frame.origin.x + CGFloat(screenWidth!)
        let yPosition = currentlyDisplayed!.frame.origin.y
        
        let height = currentlyDisplayed!.frame.size.height
        let width = currentlyDisplayed!.frame.size.width
        
        UIView.animateWithDuration(1.0, animations: {
            currentlyDisplayed!.frame = CGRectMake(xPosition, yPosition, width, height)
        })
    }
    
}