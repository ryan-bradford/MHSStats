//
//  TopBar.swift
//  MHSStats
//
//  Created by Ryan on 3/11/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit

public class TopBar: UIView {
    
    var backButton: BackButton?
    var superScreen: ScreenDisplay?
    var screenWidth: Int?
    
    public init(width : Int, superScreen: ScreenDisplay) {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: FileStructure.topBarHeight))
        self.superScreen = superScreen
        self.screenWidth = width
        initButton()
    }

    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func slideOnBackButton() {
        let xPosition = backButton!.frame.origin.x - CGFloat(screenWidth!)
        let yPosition = backButton!.frame.origin.y
        
        let height = backButton!.frame.size.height
        let width = backButton!.frame.size.width
        
        UIView.animateWithDuration(1.0, animations: {
            self.backButton!.frame = CGRectMake(xPosition, yPosition, width, height)
        })
    }
    
    func slideOffBackButton() {
        let xPosition = backButton!.frame.origin.x + CGFloat(screenWidth!)
        let yPosition = backButton!.frame.origin.y
        
        let height = backButton!.frame.size.height
        let width = backButton!.frame.size.width
        
        UIView.animateWithDuration(1.0, animations: {
            self.backButton!.frame = CGRectMake(xPosition, yPosition, width, height)
        })
    }
    
    func initButton() {
        backButton = BackButton(x: 10 + screenWidth!, y: 10, width: FileStructure.circleDiameter, height: FileStructure.circleDiameter, superScreen: superScreen!)
        self.addSubview(backButton!)
    }
    
}
