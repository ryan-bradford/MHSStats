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
                self.onlineProcessData()
                self.screen.records = self.records
                self.screen.newRecords = self.newRecords
            }
            else {
                //print("Faulure: %@", error!.localizedDescription);
                self.offlineProcessData()
                self.screen.records = self.records
                self.screen.newRecords = self.newRecords
            }
        })
        task.resume()
    }
    
    func onlineProcessData() {
        var HTMLSubTexts = HTML.characters.split {$0 == "₧"}.map { String($0) }
        writeText(HTML)
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
    
    func offlineProcessData() {
        if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            let path = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent("html.txt")
            let filePath = path.URLByAppendingPathComponent("nameOfFileHere").path!
            let fileManager = NSFileManager.defaultManager()
            if fileManager.fileExistsAtPath(filePath) {
                
            }
            do {
                HTML = try NSString(contentsOfURL: path, encoding: NSUTF8StringEncoding) as String
            }
            catch {
                //print("Error")
            }
        }
        var HTMLSubTexts = HTML.characters.split {$0 == "₧"}.map { String($0) }
        HTMLSubTexts = HTML.characters.split {$0 == "₧"}.map { String($0) }
        var teamTexts = HTMLSubTexts[1].characters.split {$0 == "@"}.map { String($0) }
        for i in 1 ..< teamTexts.count - 1 {
            records.append(Array<Array<Record>>())
            processText(teamTexts[i], index: i - 1)
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
        let theRecord = Record(name : name, mainData: data, dataUnits: dataUnits, year: Double(year!), teamName: teamName, eventName: eventName, categoryName: categoryName)
        return theRecord
    }
    
    func writeText(text: String) {
        if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            let path = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent("html.txt")
            do {
                try text.writeToURL(path, atomically: false, encoding: NSUTF8StringEncoding)
            }
            catch {
                return
            }
        }
    }
}