//
//  AppDelegate.swift
//  WaterWorld
//
//  Created by Amr Mahmoud on 2020-02-04.
//  Copyright © 2020 Amr Mahmoud. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.badge,.alert,.sound]){(granted,error) in}
        
//        let content = UNMutableNotificationContent()
//        content.title = NSString.localizedUserNotificationString(forKey: "Drink Water", arguments: nil)
//        content.body = NSString.localizedUserNotificationString(forKey: "It's time to drink water.",
//                                                                arguments: nil)
//        content.sound = UNNotificationSound.default
//        
//        // Configure the trigger for a 7am wakeup.
////        var dateInfo = DateComponents()
////        dateInfo.hour = 15
////        dateInfo.minute = 14
////        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
////        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (180*60), repeats: true)
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (60), repeats: true)
//        // Create the request object.
//        let request = UNNotificationRequest(identifier: "WaterAlarm", content: content, trigger: trigger)
//        
//        center.add(request) { (error : Error?) in
//            if let theError = error {
//                print(theError.localizedDescription)
//            }
//        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

