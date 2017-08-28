//
//  AlarmViewModel.swift
//  AlarmApp
//
//  Created by Kuliza-282 on 28/08/17.
//  Copyright © 2017 Kuliza-282. All rights reserved.
//

import Foundation
import UserNotifications

protocol AlarmViewModel {
    
    func setAlarm(title:String,timeInterval:Double)
    var didError: ((String) -> Void)? { get set }
    var didSuccess: ((String) -> Void)? { get set }
    var isAlarmSet:Dynamic<Bool> { get }

}

class AlarmViewModelling:AlarmViewModel {
    
    var didError:((String) -> Void)?
    var didSuccess: ((String) -> Void)?
    private(set) var isAlarmSet : Dynamic<Bool> = Dynamic(false)

    func setAlarm(title:String,timeInterval:Double) {
        
        if title == "" || timeInterval == 0.0 {
            self.didError?("Please enter valid title and Time Interval!")
        }else{
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = "Wake Up Alarm"
            content.sound =  UNNotificationSound.init(named: "out1.caf")
            content.categoryIdentifier = Notifications.Categories.Message.rawValue
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: true)

            let identifier = Notifications.Categories.Message.rawValue
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request){ (error) in
                if let theerror = error {
                    self.isAlarmSet.value = false
                    self.didError?("Something went wrong")
                }else{
                    self.isAlarmSet.value = true
                    self.didSuccess?("Success")

                }
                
            }
        }
    }

}
