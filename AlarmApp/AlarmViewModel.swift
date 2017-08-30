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

    func validate(title:String,timeInterval:Double) -> Bool
    func setAlarm(title:String,timeInterval:Double)
    func createLocalNotificationRequest(title:String, timeInterval:Double) -> UNNotificationRequest
    var didError: ((String) -> Void)? { get set }
    var didSuccess: ((String) -> Void)? { get set }

}

class AlarmViewModelling:AlarmViewModel {
    
    var didError:((String) -> Void)?
    var didSuccess: ((String) -> Void)?
    let scheduler : LocalNotificationScheduler
    
    init(scheduler:LocalNotificationScheduler){
        self.scheduler = scheduler
    }
    
    
    //This method validate the tile & timeinterval params.
    // If valid create localnotifcation else show the error.
    func setAlarm(title:String,timeInterval:Double) {
        
        scheduler.userOptedInForLocalNotifications { [weak self] status in
            if status {
                    let request = self?.createLocalNotificationRequest(title: title, timeInterval: timeInterval)
                    self?.registerNotification(request: request!)
            }else {
                self?.didError?(AppConstants.AlarmVC.notificationDontAllowPermissionMsg)
            }
            
        }
    }
    
    
    func validate(title:String,timeInterval:Double) -> Bool {
        if title == "" || timeInterval == 0.0 {
            self.didError?(AppConstants.AlarmVC.emptyTitleOrTimeIntervalErrorMsg)
            return false
        }
        return true
    }

    
       
    
    
    //This method is used for create notification 
    func createLocalNotificationRequest(title:String, timeInterval:Double) -> UNNotificationRequest{
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
    func registerNotification(request : UNNotificationRequest){
        scheduler.registerNotification(request: request) { status in
            if status {
                self.didSuccess?(AppConstants.AlarmVC.successMsg)
            }else{
                self.didError?(AppConstants.AlarmVC.somethingWentWrong)
            }
            
        }
        
    }

}
