//
//  AppDelegate.swift
//  MHSStats
//
//  Created by Ryan on 3/8/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    //Change to Remote Notifications
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        application.setMinimumBackgroundFetchInterval(
        UIApplicationBackgroundFetchIntervalMinimum)
         let notificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
         let pushNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
         application.registerUserNotificationSettings(pushNotificationSettings)
         application.registerForRemoteNotifications()
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        completionHandler(UIBackgroundFetchResult.NewData)
        checkHash(application)
    }
    
    func checkHash(application: UIApplication) {
        var lastHash = ""
        var currentHash = ""
        var message = ""
        if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            let path = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent("hash.txt")
            let filePath = path.URLByAppendingPathComponent("hash").path!
            let fileManager = NSFileManager.defaultManager()
            if fileManager.fileExistsAtPath(filePath) {
                
            }
            do {
                lastHash = try NSString(contentsOfURL: path, encoding: NSUTF8StringEncoding) as String
            }
            catch {
                //print("Offline Error")
            }
        }
        NSURLCache.sharedURLCache().removeAllCachedResponses()
        let URL = NSURL(string: "http://mmiillkkaa.hopto.org/rbradford/hash.txt")
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(URL: URL!)
        request.HTTPMethod = "GET"
        let task = session.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if (error == nil) {
                let text = String(NSString(data: data!, encoding: NSUTF8StringEncoding))
                let textParts = text.characters.split {$0 == "₧"}.map { String($0) }
                currentHash = textParts[1]
                message = textParts[3]
                if(currentHash != lastHash) {
                    self.sendNotification(message, application: application)
                    self.writeText(currentHash)
                }
            } else {
                //print("Faulure: %@", error!.localizedDescription);
            }
        })
        task.resume()
        
    }
    
    func writeText(text: String) {
        if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            let path = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent("hash.txt")
            do {
                try text.writeToURL(path, atomically: false, encoding: NSUTF8StringEncoding)
            }
            catch {
                return
            }
        }
    }
    
    func sendNotification(message: String, application: UIApplication) {
        let notification = UILocalNotification()
        notification.alertBody = message  // text that will be displayed in the notification
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = NSDate(timeIntervalSinceNow: 0)
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.category = "TODO_CATEGORY"
        application.scheduleLocalNotification(notification)
    }
    
    
}


