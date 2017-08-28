//
//  Utility.swift
//  AlarmApp
//
//  Created by Kuliza-282 on 28/08/17.
//  Copyright © 2017 Kuliza-282. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
struct Utility {
    
    static func displayAlert(title: String) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okButton)
        alertController.title = title
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            if vc.presentedViewController != nil {
                alertController.dismiss(animated: false, completion: {
                    vc.present(alertController, animated: true, completion: nil)
                })
            } else {
                vc.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    static func userOptedInForLocalNotifications(completion:@escaping (Bool) -> Void)   {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            if settings.authorizationStatus != .authorized {
                completion(false)
            }
            completion(true)
            
        }
    }

}
