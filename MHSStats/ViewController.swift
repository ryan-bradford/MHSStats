//
//  ViewController.swift
//  MHSStats
//
//  Created by Ryan on 3/8/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var screenWidth = Int(UIScreen.mainScreen().bounds.width) //Final
    var screenHeight = Int(UIScreen.mainScreen().bounds.height) //Final
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screen = ScreenDisplay(x: 0, y: 0, width: screenWidth, height : screenHeight)
        self.view.addSubview(screen)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

