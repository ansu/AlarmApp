//
//  ViewController.swift
//  AlarmApp
//
//  Created by Kuliza-282 on 28/08/17.
//  Copyright © 2017 Kuliza-282. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var deadlinePicker: UIDatePicker!
    
    @IBAction func savePressed(_ sender: UIButton) {
   
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.body = "Wake Up Alarm"
        content.sound =  UNNotificationSound.init(named: "out1.caf")
        content.categoryIdentifier = Notifications.Categories.Message.rawValue
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        
        let identifier = Notifications.Categories.Message.rawValue
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request){ (error) in
            if let theerror = error {
                print ("something went wrong")
            }else{
                print("working fine")
            }
            
        }

    }
    
    
    
    
    
    

}

