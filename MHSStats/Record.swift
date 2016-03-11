//
//  Record.swift
//  MHSStats
//
//  Created by Ryan on 3/8/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation

public class Record {
    
    public var mainData: String
    public var dataUnits : String
    public var year : Int
    public var teamName : String
    public var eventName : String
    public var categoryName : String
    public var personName : String
    
    public init(name : String, mainData : String, dataUnits : String, year : Int, teamName : String, eventName : String, categoryName : String) {
        self.mainData = mainData
        self.dataUnits = dataUnits
        self.year = year
        self.eventName = eventName
        self.teamName = teamName
        self.categoryName = categoryName
        self.personName = name
        self.categoryName = stripSlashN(categoryName)
        self.teamName = stripSlashN(teamName)
    }
    
    func stripSlashN(stuff : NSString) -> String {
        let splitPoint = (stuff as String).characters.count
        return stuff.substringWithRange(NSMakeRange(0, splitPoint - 2))
    }
    
    
}
