//
//  ChildRegistrationController.swift
//  APPYSTORE
//
//  Created by ios_dev on 17/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class ChildRegistrationController: BaseViewController {
    
    @IBOutlet weak var tfBirthDate: UITextField!
    
    
    override func getPageName() -> String {
        return PageConstants.REGISTRATION_PAGE
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func birthDateEditingDidBegin(_ sender: UITextField) {
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(dismissPicker))
        tfBirthDate.inputAccessoryView = toolBar
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        tfBirthDate.text = dateFormatter.string(from: sender.date)
    }
    
    func dismissPicker() {
        view.endEditing(true)
    }
    
    @IBAction func saveTouchUpInside(_ sender: CustomButton) {
        //open avatar selection page
    }
}