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
    var screenWidth: Double?
    var mGraphic: MGraphic?
    
    public init(width : Double, superScreen: ScreenDisplay) {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: FileStructure.topBarHeight))
        self.superScreen = superScreen
        self.screenWidth = width
        mGraphic = MGraphic(screenWidth: (width), y: (FileStructure.standardOffset + 4))
        self.addSubview(mGraphic!)
        initButton(Double(mGraphic!.frame.height))
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
    
    func initButton(height: Double) {
        backButton = BackButton(x: 20.0, y: FileStructure.standardOffset, width: FileStructure.circleDiameter + 6.0, height: FileStructure.circleDiameter + 6.0, superScreen: superScreen!)
        self.addSubview(backButton!)
        self.backButton!.alpha = 0.0
        self.backButton!.alpha = 0.0
        self.backButton!.alpha = 0.0
    }
    
}
