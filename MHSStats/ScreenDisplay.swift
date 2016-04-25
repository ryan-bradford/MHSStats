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
    var newRecords: Array<Record>?
    var categoryIDDisplayed: Int?
    
    public init(x : Int, y : Int, width : Int, height : Int) {
        self.screenWidth = width
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        topBar = TopBar(width: screenWidth!, superScreen: self)
        addSubview(topBar!)
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func transitionFromTeamsToCategories(team : Int) {
        topBar?.slideOnBackButton(1.0)
        let xPosition = categoryScreens![team].frame.origin.x - CGFloat(screenWidth!)
        let yPosition = categoryScreens![team].frame.origin.y
        
        let height = categoryScreens![team].frame.size.height
        let width = categoryScreens![team].frame.size.width
        
        categoryScreens![team].setVisible()
        
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
        
        recordsScreens![team][category].setVisible()
        
        UIView.animateWithDuration(1.0, animations: {
            self.recordsScreens![team][category].frame = CGRectMake(xPosition, yPosition, width, height)
        })
        
        teamIDDisplayed = team
        categoryIDDisplayed = category
    }
    
    func transitionBackwards(speed: Double) {
        var currentlyDisplayed: MyScrollView?
        if(teamIDDisplayed == nil && categoryIDDisplayed == nil) {
            return
        } else if(categoryIDDisplayed == nil) {
            topBar?.slideOffBackButton(speed)
            currentlyDisplayed = categoryScreens![teamIDDisplayed!]
            teamsScreen!.setVisible()
            teamIDDisplayed = nil
        } else {
            currentlyDisplayed = recordsScreens![teamIDDisplayed!][categoryIDDisplayed!]
            categoryScreens![teamIDDisplayed!].setVisible()
            categoryIDDisplayed = nil
        }
        
        let xPosition = currentlyDisplayed!.frame.origin.x + CGFloat(screenWidth!)
        let yPosition = currentlyDisplayed!.frame.origin.y
        
        let height = currentlyDisplayed!.frame.size.height
        let width = currentlyDisplayed!.frame.size.width
        
        UIView.animateWithDuration(speed, animations: {
            currentlyDisplayed!.frame = CGRectMake(xPosition, yPosition, width, height)
        })
    }
    
    func loadAndProcessRecords() {
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            _ = TextProcessor(screen: self)
        }
    }
    
    func displayRecords(x : Int, y : Int, width : Int, height : Int) {
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            while(self.records == nil) {
                
            }
            let pushDown = FileStructure.topBarHeight
            dispatch_async(dispatch_get_main_queue()) {
                self.categoryScreens = Array<CategoryScreen>()
                self.recordsScreens = Array<Array<RecordsScreen>>()
                for i in 0 ..< self.records!.count {
                    self.recordsScreens!.append(Array<RecordsScreen>())
                    self.categoryScreens!.append(CategoryScreen(x: width, y: pushDown, width: width, height: height, records: self.records![i], teamID: i, superScreen: self))
                    for x in 0 ..< self.records![i].count {
                        self.recordsScreens![i].append(RecordsScreen(x: width, y: pushDown, width: width, height: height, records: self.records![i][x], superScreen: self))
                    }
                }
                self.teamsScreen = TeamsScreen(x: 0, y: pushDown, width: width, height: height, records: self.records!, superScreen: self)
                self.teamsScreen!.setVisible()
                self.teamsScreen!.alpha = 0.0
                self.addSubview(self.teamsScreen!)
                UIView.animateWithDuration(0.7, animations: {
                    self.teamsScreen!.alpha = 1.0
                    self.teamsScreen!.newRecordsBar!.alpha = 1.0
                    }, completion: {
                        (value: Bool) in
                        for i in 0 ..< self.recordsScreens!.count {
                            self.addSubview(self.categoryScreens![i])
                        }
                        
                        for i in 0 ..< self.recordsScreens!.count {
                            for x in 0 ..< self.recordsScreens![i].count {
                                self.addSubview(self.recordsScreens![i][x])
                            }
                        }
                })
                
            }
        }
    }
}