//
//  AppDelegate.swift
//  Positio
//
//  Created by Bhagat Singh on 2/11/17.
//  Copyright © 2017 com.bhagat_singh. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound]) { (accepted, error) in
            if accepted == false{
                print("Not accepted!")
            }
        }
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 0.0/255.0, green: 230.0/255.0, blue: 118.0/255.0, alpha: 1.0)
        
        if let barFont = UIFont(name: "Avenir-Light", size: 22.0){
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white,NSFontAttributeName : barFont]
        }
        return true
    }
    
    
    func scheduleNotifications(at date:Date){
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        _ = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder!!"
        content.body = "Just a reminder to place you in your correct posture"
        content.sound = UNNotificationSound.default()
        
        if let path = Bundle.main.path(forResource: "videoplayback", ofType: "mp4") {
            let url = URL(fileURLWithPath: path)
            
            do {
                let attachment = try UNNotificationAttachment(identifier: "videoplayback", url: url, options: nil)
                content.attachments = [attachment]
            } catch {
                print("The attachment was not loaded.")
            }
        }
        
        let request = UNNotificationRequest(identifier: "textNotif", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error{
                print("We have an error \(error)")
            }
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { (timer) in
            let delegate = UIApplication.shared.delegate as? AppDelegate
            delegate?.scheduleNotifications(at: Date(timeIntervalSinceNow: TimeInterval(exactly: 5.0)!))
            
        }

        
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

