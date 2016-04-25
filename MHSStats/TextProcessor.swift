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
    var newRecords = Array<Record>()
    var HTML = ""
    var screen: ScreenDisplay
    public init(screen: ScreenDisplay) {
        self.screen = screen
        self.readTeams()
    }
    
    func load(URL: NSURL) {
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(URL: URL)
        request.HTTPMethod = "GET"
        let task = session.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if (error == nil) {
                self.HTML = String(NSString(data: data!, encoding: NSUTF8StringEncoding))
                self.processData()
                self.screen.records = self.records
                self.screen.newRecords = self.newRecords
            }
            else {
                print("Faulure: %@", error!.localizedDescription);
            }
        })
        task.resume()
    }
    
    func processData() {
        var HTMLSubTexts = HTML.characters.split {$0 == "₧"}.map { String($0) }
        if(HTMLSubTexts == Array<String>()) {
            print("File")
            do {
                try HTML = NSString(contentsOfFile: "html.txt", encoding: NSUTF16BigEndianStringEncoding) as String} catch {
                    
                    return
            }
            HTMLSubTexts = HTML.characters.split {$0 == "₧"}.map { String($0) }
            var teamTexts = HTMLSubTexts[1].characters.split {$0 == "@"}.map { String($0) }
            for i in 1 ..< teamTexts.count - 1 {
                records.append(Array<Array<Record>>())
                processText(teamTexts[i], index: i - 1)
            }
        } else {
            var teamTexts = HTMLSubTexts[1].characters.split {$0 == "@"}.map { String($0) }
            for i in 1 ..< teamTexts.count - 1 {
                records.append(Array<Array<Record>>())
                processText(teamTexts[i], index: i - 1)
            }
            var newRecordsTexts = HTMLSubTexts[2].characters.split {$0 == "?"}.map { String($0) }
            for i in 1 ..< newRecordsTexts.count {
                newRecords.append(processRecord(newRecordsTexts[i]))
            }
            
        }

    }
    
    func readTeams() {
        let myURLString = "http://mmiillkkaa.hopto.org/rbradford/TeamData.txt"
        load(NSURL(string: myURLString)!)
    }
    
    func processText(group : String, index : Int) {
        var teamSubTexts = group.characters.split {$0 == "!"}.map { String($0) }
        for i in 0 ..< teamSubTexts.count - 1 {
            records[index].append(Array<Record>())
            processTeam(teamSubTexts[i], index1: index, index2: i - 1)
        }
    }
    
    func processTeam(group : String, index1 : Int, index2 : Int) {
        var categoryTexts = group.characters.split {$0 == "?"}.map { String($0) }
        for i in 1 ..< categoryTexts.count {
            records[index1][index2].append(processRecord(categoryTexts[i]))
        }
    }
    
    func processRecord(record : String) -> Record {
        let recordTexts = record.characters.split {$0 == ","}.map { String($0) }
        let teamName = recordTexts[5]
        let categoryName = recordTexts[6]
        let data = (recordTexts[2])
        let dataUnits = recordTexts[3]
        let year = Int(recordTexts[4])
        let eventName = recordTexts[1]
        let name = recordTexts[0]
        let theRecord = Record(name : name, mainData: data, dataUnits: dataUnits, year: year!, teamName: teamName, eventName: eventName, categoryName: categoryName)
        return theRecord
    }
    
    func writeText(text: String) {
        do {
            try text.writeToFile("html.txt", atomically: false, encoding: NSUTF16BigEndianStringEncoding)}
            
        catch {
            
        }
    }
}