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
    
    func setAlarm(title:String)
    
    var didError: ((String) -> Void)? { get set }
    var didSuccess: ((String) -> Void)? { get set }

    
}

class AlarmViewModelling:AlarmViewModel {
    
    var didError:((String) -> Void)?
    var didSuccess: ((String) -> Void)?
    
    func setAlarm(title: String = "Alarm") {
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "Wake Up Alarm"
        content.sound =  UNNotificationSound.init(named: "out1.caf")
        content.categoryIdentifier = Notifications.Categories.Message.rawValue
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)

//        let trigger =  UNCalendarNotificationTrigger.init(dateMatching: NSCalendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: deadlinePicker.date), repeats: true)
        
        let identifier = Notifications.Categories.Message.rawValue
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request){ (error) in
            if let theerror = error {
                self.didError?("Something went wrong")
            }else{
                self.didSuccess?("Success")

            }
            
        }
    }

}
