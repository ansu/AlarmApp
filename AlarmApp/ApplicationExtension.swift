//
//  ApplicationExtension.swift
//  AlarmApp
//
//  Created by Kuliza-282 on 30/08/17.
//  Copyright © 2017 Kuliza-282. All rights reserved.
//

import Foundation
import UserNotifications




extension Application:LocalNotificationSchedulable {
    
    func cancelAllLocalNotifications() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
    }
    
    
    func getLocalNotificationPermissionStatus(completion:@escaping (Bool) -> Void)   {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            if settings.authorizationStatus != .authorized {
                completion(false)
            }
            completion(true)
            
        }
    }
    
    func scheduleNotifcation(request:UNNotificationRequest, completion:@escaping (Bool) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.add(request){ (error) in
            if let _ = error {
                completion(false)
            }else{
                completion(true)
            }
        }
    }

}
