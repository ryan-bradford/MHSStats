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
    var mGraphic: MGraphic?
    
    public init(width : Int, superScreen: ScreenDisplay) {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: FileStructure.topBarHeight))
        self.superScreen = superScreen
        self.screenWidth = width
        mGraphic = MGraphic(screenWidth: Int(width), y: Int(FileStructure.standardOffset))
        self.addSubview(mGraphic!)
        initButton(Int(mGraphic!.frame.height))
    }

    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func slideOnBackButton(speed: Double) {
        UIView.animateWithDuration(speed, animations: {
            self.backButton!.alpha = 1.0
            self.backButton!.alpha = 1.0
            self.backButton!.alpha = 1.0
        })
    }
    
    func slideOffBackButton(speed: Double) {
        UIView.animateWithDuration(speed, animations: {
            self.backButton!.alpha = 0.0
            self.backButton!.alpha = 0.0
            self.backButton!.alpha = 0.0
        })
    }
    
    func initButton(height: Int) {
        backButton = BackButton(x: 20, y: FileStructure.standardOffset, width: height, height: height, superScreen: superScreen!)
        self.addSubview(backButton!)
        self.backButton!.alpha = 0.0
        self.backButton!.alpha = 0.0
        self.backButton!.alpha = 0.0
    }
    
}
