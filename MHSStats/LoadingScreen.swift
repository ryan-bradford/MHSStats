//
//  LoadingScreen.swift
//  MHSStats
//
//  Created by Ryan on 6/6/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit

public class LoadingScreen: UIMethods {
    
    public init(width: Double, height: Double) {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.backgroundColor = UIColor.clearColor()
        self.alpha = 0.0
        
    }
    
    public override func drawRect(rect: CGRect) {
        self.drawCenteredTextInRect(0, y: 0, width: rect.size.width, height: rect.size.height, toDraw: "Loading...", fontSize: 30)
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func fadeIn(speed: Double) {
        UIView.animateWithDuration(speed, animations: {
            self.alpha = 1.0
        })
    }
    
    func fadeOut(speed: Double) {
        UIView.animateWithDuration(speed, animations: {
            self.alpha = 0.0
        })
    }
    
}