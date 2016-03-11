//
//  TextProcessor.swift
//  MHSStats
//
//  Created by Ryan on 3/8/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation

public class TextProcessor {
    
    var records = Array<Array<Array<Record>>>()
    
    public init() {
        self.readTeams()
    }
    
    func readTeams() {
        let myURLString = "https://docs.google.com/document/d/1YFzqzjZnrK1HsAk9wN5uy4ZDozBoMyTFrZkC8OINrfM/edit?usp=sharing"
        var HTML = ""
        if let myURL = NSURL(string: myURLString) {
            do {
                let myHTMLString = try NSString(contentsOfURL: myURL, encoding: NSUTF8StringEncoding)
                HTML = myHTMLString as String
            } catch {
                print("error")
            }
        } else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
        }
        var HTMLSubTexts = HTML.characters.split {$0 == "₧"}.map { String($0) }
        var teamTexts = HTMLSubTexts[2].characters.split {$0 == "@"}.map { String($0) }
        for var i = 1; i < teamTexts.count - 1; i++ {
            records.append(Array<Array<Record>>())
            processTeam(teamTexts[i], index: i - 1)
        }
    }
    
    func processTeam(group : String, index : Int) {
        var teamSubTexts = group.characters.split {$0 == "!"}.map { String($0) }
        for var i = 1; i < teamSubTexts.count - 1; i++ {
            records[index].append(Array<Record>())
            processTeam(teamSubTexts[i], teamName: teamSubTexts[0], index1: index, index2: i - 1)
        }
    }
    
    func processTeam(group : String, teamName : String, index1 : Int, index2 : Int) {
        var categoryTexts = group.characters.split {$0 == "?"}.map { String($0) }
        for var i = 1; i < categoryTexts.count; i++ {
            records[index1][index2].append(processWaypoint(categoryTexts[i], teamName : teamName, categoryName: categoryTexts[0]))
        }
    }
    
    func processWaypoint(record : String, teamName : String, categoryName : String) -> Record {
        let recordTexts = record.characters.split {$0 == ","}.map { String($0) }
        let teamName = teamName
        let categoryName = categoryName
        let data = (recordTexts[2])
        let dataUnits = recordTexts[3]
        let year = Int(recordTexts[4])
        let eventName = recordTexts[1]
        let name = recordTexts[0]
        let theRecord = Record(name : name, mainData: data, dataUnits: dataUnits, year: year!, teamName: teamName, eventName: eventName, categoryName: categoryName)
        return theRecord
    }
}