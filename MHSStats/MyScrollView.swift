
//
//  File.swift
//  MHSStats
//
//  Created by Ryan on 3/10/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit

public class MyScrollView : UIScrollView {
    
    var superScreen : ScreenDisplay?
    var visible: Bool?

    public init(frame: CGRect, superScreen: ScreenDisplay) {
        self.superScreen = superScreen
        super.init(frame: frame)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required public init(coder aDecoder: NSCoder) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
}
