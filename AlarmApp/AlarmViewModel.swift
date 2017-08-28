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

    //This method validate the tile & timeinterval params.
    // If valid create localnotifcation else show the error.
    func setAlarm(title:String,timeInterval:Double) {
        
        Utility.userOptedInForLocalNotifications { [weak self] status in
            print(status)
            if status {
                if title == "" || timeInterval == 0.0 {
                    self?.didError?(AppConstants.AlarmVC.emptyTitleOrTimeIntervalErrorMsg)
                }else{
                    let request = self?.createLocalNotificationRequest(title: title, timeInterval: timeInterval)
                    self?.registerNotification(request: request!)
                }

            }else {
                self?.didError?(AppConstants.AlarmVC.notificationDontAllowPermissionMsg)
            }
            
            
        }
    }
    
    
    
    //This method is used for create notification 
    private func createLocalNotificationRequest(title:String, timeInterval:Double) -> UNNotificationRequest{
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "Wake Up Alarm"
        content.sound =  UNNotificationSound.init(named: "out1.caf")
        content.categoryIdentifier = Notifications.Categories.Message.rawValue
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: true)
        
        let identifier = Notifications.Categories.Message.rawValue
        return  UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
    }
    
   
    //This method is used to Register Notification.
    private func registerNotification(request : UNNotificationRequest){
        let center = UNUserNotificationCenter.current()
        center.add(request){ (error) in
            if let _ = error {
                self.isAlarmSet.value = false
                self.didError?(AppConstants.AlarmVC.somethingWentWrong)
            }else{
                self.isAlarmSet.value = true
                self.didSuccess?(AppConstants.AlarmVC.successMsg)
                
            }
        }

    }

}
