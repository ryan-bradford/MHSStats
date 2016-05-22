//
//  Record.swift
//  MHSStats
//
//  Created by Ryan on 3/8/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation

public class Record {
    
    public var mainData: String //Done
    public var dataUnits : String //Done
    public var year : Double
    public var teamName : String //Done
    public var eventName : String //Done
    public var categoryName : String //Done
    public var personName : String //Done
    
    public init(name : String, mainData : String, dataUnits : String, year : Double, teamName : String, eventName : String, categoryName : String) {
        self.mainData = mainData
        self.dataUnits = dataUnits
        self.year = year
        self.eventName = eventName
        self.teamName = teamName
        self.categoryName = categoryName
        self.personName = name
        self.categoryName = categoryName
        self.teamName = teamName
    }
    
    func getStripedName() -> String {
        var toDisplay = self.personName.copy() as! String
        toDisplay = toDisplay.stringByReplacingOccurrencesOfString("_", withString: " ")
        return toDisplay
    }
    
    func getQuickName() -> String {
        var totalParts = personName.characters.split {$0 == "_"}.map { String($0) }
        var quickName = ""
        for var x in totalParts {
            var nameParts = x.characters.split {$0 == " "}.map { String($0) }
            for i in 0 ..< nameParts.count {
                quickName.append((nameParts[i].characters.first! as Character))
                quickName.append("." as Character)
            }
            quickName.append(" " as Character)
        }
        return quickName
    }
    
}
