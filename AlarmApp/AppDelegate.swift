//
//  AppDelegate.swift
//  AlarmApp
//
//  Created by Kuliza-282 on 28/08/17.
//  Copyright © 2017 Kuliza-282. All rights reserved.
//

import UIKit
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var app: Application?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
        registerForNotifications()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.app = Application(window:window)
        self.window = window
        
        let _ = self.app?.navigation
        
        return true
    }

    func registerForNotifications() {
        
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .badge,.sound]
        
        center.requestAuthorization(options: options)  { (granted, error) in
            if granted {
                let snoozeAction = UNNotificationAction(identifier: Notifications.Actions.Snooze.rawValue,
                                                        title: Notifications.Actions.Snooze.rawValue,
                                                        options: [.destructive])
                let stop = UNNotificationAction(identifier: Notifications.Actions.Stop.rawValue,
                                                title: Notifications.Actions.Stop.rawValue,
                                                options: [.foreground])
                let alarmCategory = UNNotificationCategory(identifier:Notifications.Categories.Message.rawValue,
                                                           actions: [snoozeAction, stop],
                                                           intentIdentifiers: [],options: [])
                
                UNUserNotificationCenter.current().setNotificationCategories([alarmCategory])
                
                print(" granted")
            }else {
                print("not granted")
            }
        }
    }
    

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        NotificationParser.shared.handleNotification(response)
        
        completionHandler()

    }
        
}


