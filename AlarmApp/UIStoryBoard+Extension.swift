//
//  UIStoryBoard+Extension.swift
//  AlarmApp
//
//  Created by Kuliza-282 on 28/08/17.
//  Copyright © 2017 Kuliza-282. All rights reserved.
//

import  UIKit

extension UIStoryboard {
    
    public static var mainStoryboard:UIStoryboard?{
        let bundle = Bundle.main
        
        guard let name = bundle.object(forInfoDictionaryKey: "UIMainStoryboardFile") as? String else {
            return nil
        }
        return UIStoryboard(name: name, bundle: bundle)
    }
    
    public func instantiateVC<T>(_ identifier : T.Type) -> T?{
        
        let storyboardID = String(describing: identifier)
        if let vc = instantiateViewController(withIdentifier: storyboardID) as? T {
            return vc
        } else {
            return nil
        }

    }
    
    
}
