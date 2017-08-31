//
//  Router.swift
//  AlarmApp
//
//  Created by Kuliza-282 on 28/08/17.
//  Copyright © 2017 Kuliza-282. All rights reserved.
//

import Foundation
import UIKit

final class Router {
    //MARK: - Private
    var navigationController: UINavigationController
    let application: Application
    
    //MARK: - Lifecycle
    init(window: UIWindow, application: Application) {
        self.navigationController = UINavigationController()
        self.application = application
        self.navigationController.setNavigationBarHidden(true, animated: true)
        self.start()
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
    }

    func start(){
        
        let localNotificationScheduler = LocalNotificationScheduler(application: self.application as! LocalNotificationSchedulable)
        
        let viewModel = AlarmViewModelling(scheduler: localNotificationScheduler)
        let instance = UIStoryboard.mainStoryboard?.instantiateVC(AlarmVC.self)
        instance?.viewModel = viewModel
        self.navigationController = UINavigationController(rootViewController: instance!)
        
    }
    

}
