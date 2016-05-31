//
//  NewRecordsBar.swift
//  MHSStats
//
//  Created by Ryan on 4/6/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit

public class NewRecordsBar: UIScrollView {
    
    var newRecords: Array<Record>?
    var newRecordButtons = Array<NewRecordButton>()
    
    init(screenWidth: Double, newRecords: Array<Record>, screen: ScreenDisplay) {
        self.newRecords = newRecords
        super.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: FileStructure.newRecordsBarHeight))
        for i in 0 ..< newRecords.count {
            let toAdd = NewRecordButton(x: FileStructure.newRecordButtonGap / 2.0 + Double(i) * FileStructure.newRecordsBarHeight, y: FileStructure.newRecordButtonGap / 2.0, screen: screen, record: newRecords[i])
            newRecordButtons.append(toAdd)
            addSubview(toAdd)
        }
        let neededWidth = FileStructure.newRecordButtonGap + (Double(newRecords.count)) * FileStructure.newRecordsBarHeight
        self.contentSize = (CGSizeMake(CGFloat(neededWidth), CGFloat(FileStructure.newRecordsBarHeight)))
        self.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.backgroundColor = UIColor.clearColor()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    override public func drawRect(rect: CGRect) {
        if(newRecords!.count == 0) {
            drawCenteredTextInRect(0, y: 0, width: CGFloat(rect.width), height: CGFloat(FileStructure.newRecordsBarHeight), toDraw: "No New Records", fontSize: 20)
        }
    }
    
    func drawCenteredTextInRect(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, toDraw: String, fontSize: CGFloat) -> CGFloat {
        let message: NSMutableAttributedString = NSMutableAttributedString(string: toDraw)
        
        let fieldColor: UIColor = UIColor.blackColor()
        let fieldFont = UIFont(name: "Helvetica Neue", size: CGFloat(fontSize))
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.alignment = NSTextAlignment.Center
        
        let attributes: NSDictionary = [
            NSForegroundColorAttributeName: fieldColor,
            NSParagraphStyleAttributeName: paraStyle,
            NSFontAttributeName: fieldFont!
        ]
        let countString = (message.length)
        message.addAttributes(attributes as! [String : AnyObject], range: NSRange(location: 0, length: countString) )
        let textHeight = self.heightWithConstrainedWidth(self.frame.width, font: UIFont.boldSystemFontOfSize(25), toGet: toDraw)
        message.drawInRect(CGRectMake(x, height / 2 - textHeight / 2 + y, width, height))
        return textHeight
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont, toGet: String) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.max)
        
        let boundingBox = toGet.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}

