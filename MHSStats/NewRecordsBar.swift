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
        let neededWidth = FileStructure.newRecordButtonGap / 2.0 + (Double(newRecords.count) - 1.0) * FileStructure.newRecordsBarHeight
        self.contentSize = (CGSizeMake(CGFloat(neededWidth), CGFloat(FileStructure.newRecordsBarHeight)))
        self.autoresizingMask = UIViewAutoresizing.FlexibleWidth
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}
