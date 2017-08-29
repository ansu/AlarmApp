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
    var pickOption = [60, 80, 90, 100,200,250]
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var pickerTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Notifation"
        self.setUpPicker()
        setupBinding()
    }
    
    //This Method used for binding the view Model events.
    private func setupBinding(){
        viewModel?.didError  = {  errorMsg in
            Utility.displayAlert(title: errorMsg)
        }
        viewModel?.didSuccess = {  [weak self] succcessMsg in
            DispatchQueue.main.async {
                self?.titleField.text = AppConstants.AlarmVC.titlePlaceholderText
                self?.pickerTextField.text = AppConstants.AlarmVC.timeIntervalPlaceholderText
            }
            Utility.displayAlert(title: succcessMsg)
        }
    }
    
    

    
    @IBAction func savePressed(_ sender: UIButton) {
        viewModel.setAlarm(title: titleField.text ?? "", timeInterval: Double(pickerTextField.text ?? "0.0") ?? 0.0)
     }
    

    
}

extension AlarmVC:UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickOption[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = String(pickOption[row])
    }
    
    func setUpPicker() {
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerTextField.inputView = pickerView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.hideKeyboard))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        pickerTextField.inputAccessoryView = toolBar
        
    }
    
    func hideKeyboard(){
        pickerTextField.resignFirstResponder()
    }
    
    
    
}

extension AlarmVC:UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}


