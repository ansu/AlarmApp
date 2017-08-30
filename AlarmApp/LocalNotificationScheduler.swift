//
//  LocalNotificationScheduler.swift
//  AlarmApp
//
//  Created by Kuliza-282 on 30/08/17.
//  Copyright © 2017 Kuliza-282. All rights reserved.
//

import Foundation
import UserNotifications

protocol LocalNotificationSchedulable : class {
    
    func cancelAllLocalNotifications()
    func getLocalNotificationPermissionStatus(completion:@escaping (Bool) -> Void)
    func scheduleNotifcation(request:UNNotificationRequest, completion:@escaping (Bool) -> Void)

}


class LocalNotificationScheduler : NSObject {
    let application : LocalNotificationSchedulable

    init(application: LocalNotificationSchedulable) {
        self.application = application
    }
    
    func removeAllNotification(){
        application.cancelAllLocalNotifications()
    }
    
    func userOptedInForLocalNotifications(completion:@escaping (Bool) -> Void) {
        application.getLocalNotificationPermissionStatus { status in
            completion(status)
        }
    }
    
    func registerNotification(request:UNNotificationRequest, completion:@escaping (Bool) -> Void){
        application.scheduleNotifcation(request: request){ status in
            completion(status)
        }
    }

}
