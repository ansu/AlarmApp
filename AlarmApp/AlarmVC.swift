//
//  AlarmVC.swift
//  AlarmApp
//
//  Created by Kuliza-282 on 28/08/17.
//  Copyright © 2017 Kuliza-282. All rights reserved.
//

import UIKit
import UserNotifications

class AlarmVC: UIViewController {
    
    
    var viewModel: AlarmViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        // Do any additional setup after loading the view.
    }
    
    
    private func setupBinding(){
        
        viewModel?.didError  = { [weak self] errorMsg in
            Utility.displayAlert(title: errorMsg)
        }
        
        viewModel?.didSuccess = { [weak self] succcessMsg in
            Utility.displayAlert(title: succcessMsg)
        }
    }

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var deadlinePicker: UIDatePicker!
    
    @IBOutlet weak var repeatFlag: UISwitch!
    @IBAction func savePressed(_ sender: UIButton) {
        viewModel.setAlarm(title: "Ansu")
     }
    

    
}

