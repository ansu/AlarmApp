//
//  Applicaton.swift
//  AlarmApp
//
//  Created by Kuliza-282 on 28/08/17.
//  Copyright © 2017 Kuliza-282. All rights reserved.
//

import Foundation
import UIKit

class Application {
    //MARK: - Dependencies
    private let window: UIWindow
    
    lazy var navigation: Router = Router(
        window: self.window,
        application: self
    )
    
    
    //    //MARK: - Lifecycle
    init(window: UIWindow) {
        self.window = window
    }
}

