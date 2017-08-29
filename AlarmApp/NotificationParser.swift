//
//  NotificationParser.swift
//  AlarmApp
//
//  Created by Kuliza-282 on 29/08/17.
//  Copyright © 2017 Kuliza-282. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationParser {
    static let shared = NotificationParser()
    private init() { }
    
    func handleNotification(_ response: UNNotificationResponse) {
        
        let center = UNUserNotificationCenter.current()
        if response.actionIdentifier == Notifications.Actions.Snooze.rawValue {
            print("snooze")
        }else if response.actionIdentifier == Notifications.Actions.Stop.rawValue {
            print("stop & move app in forground")
            center.removeAllPendingNotificationRequests()
        }

    }
}
