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
    var ways : WaysToGoBack?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initStage1()

    }
    
    func initStage1() {
        let screen = ScreenDisplay(x: 0, y: screenHeight / 2 - FileStructure.topBarHeight / 2, width: screenWidth, height : screenHeight)
        let redScreen = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        redScreen.backgroundColor = FileStructure.MHSColor
        self.view.addSubview(redScreen)
        screen.loadAndProcessRecords()
        UIView.animateWithDuration(2, animations: {
            redScreen.frame = CGRectMake(0, CGFloat(self.screenHeight + 10), CGFloat(self.screenWidth), CGFloat(self.screenHeight))
            }, completion: {
                (value: Bool) in
                self.view.addSubview(screen)
                screen.topBar!.mGraphic!.showM(self, screen: screen)
        })
    }
    
    func initStage2(screen: ScreenDisplay) {
        let xVertPosition = screen.frame.origin.x
        let yVertPosition = screen.frame.origin.y - CGFloat(screenHeight / 2 - FileStructure.topBarHeight / 2)
        
        let vertHeight = screen.frame.size.height
        let vertWidth = screen.frame.size.width
        
        UIView.animateWithDuration(2, animations: {
            screen.frame = CGRectMake(xVertPosition, yVertPosition, vertWidth, vertHeight)
            }, completion: {
                (value: Bool) in
                screen.displayRecords(0, y: 0, width: self.screenWidth, height: self.screenHeight)
                self.ways = WaysToGoBack(screen: screen)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

