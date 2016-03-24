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

public class WaysToGoBack {
    
    var motionManager : CMMotionManager?
    var screen: ScreenDisplay
    init(screen: ScreenDisplay) {
        self.screen = screen
        motionManager = CMMotionManager()
        if motionManager!.gyroAvailable {
            if motionManager!.gyroActive == false {
                motionManager!.deviceMotionUpdateInterval = 0.02;
                motionManager!.startDeviceMotionUpdates()
                motionManager!.gyroUpdateInterval = 0.02
                motionManager!.startDeviceMotionUpdatesToQueue(NSOperationQueue.currentQueue()!) {
                    [weak self] (motion, error) in
                    if motion!.userAcceleration.x < -2.5 {
                        screen.transitionBackwards(0.3)
                    }
                }
            } else {

            }
        } else {

        }
    }
    
    func setMotionManagerThread(motionManager : CMMotionManager) {
        print("Thread Started")
    }
    
}
