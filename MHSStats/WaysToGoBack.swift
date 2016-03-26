//
//  WaysToGoBack.swift
//  MHSStats
//
//  Created by Ryan on 3/23/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

//
//  MyMotionManager.swift
//  Waypointer
//
//  Created by Ryan on 1/23/16.
//  Copyright © 2016 Ryan. All rights reserved.
//

import Foundation
import CoreMotion
import UIKit

public class WaysToGoBack: NSObject {

    var panRec: UISwipeGestureRecognizer?
    var motionManager : CMMotionManager?
    var screen: ScreenDisplay
    
    init(screen: ScreenDisplay) {
        self.screen = screen
        super.init()
        self.initSwipeControl()
        self.initAccelControl()
    }
    
    func setMotionManagerThread(motionManager : CMMotionManager) {
        print("Thread Started")
    }
    
    func initSwipeControl() {
        panRec = UISwipeGestureRecognizer()
        panRec!.addTarget(self, action: #selector(WaysToGoBack.swipedView))
        screen.addGestureRecognizer(panRec!)
        screen.userInteractionEnabled = true
    }
    
    func swipedView() {
        print("Swiped")
        screen.transitionBackwards(1.0)
    }
    
    func initAccelControl() {
        motionManager = CMMotionManager()
        if motionManager!.gyroAvailable {
            if motionManager!.gyroActive == false {
                motionManager!.deviceMotionUpdateInterval = 0.02;
                motionManager!.startDeviceMotionUpdates()
                motionManager!.gyroUpdateInterval = 0.02
                motionManager!.startDeviceMotionUpdatesToQueue(NSOperationQueue.currentQueue()!) {
                    [weak self] (motion, error) in
                    if motion!.userAcceleration.x < -2.5 {
                        self!.screen.transitionBackwards(0.3)
                    }
                }
            } else {
                
            }
        } else {
            
        }
    }
    
}
