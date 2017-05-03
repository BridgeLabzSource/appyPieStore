//
//  ChildRegistrationController.swift
//  APPYSTORE
//
//  Created by ios_dev on 17/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
import Toaster

class ChildRegistrationController: BaseViewController {
    let spacingConstant = AppDelegate.DEVICE_HEIGHT/25
    @IBOutlet weak var rootStackView: UIStackView!
    
    @IBOutlet weak var bottomLabelTwo: UILabel!
    @IBOutlet weak var bottomLabelOne: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstButton: CustomButton!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var bottomStackView: UIStackView!
    @IBOutlet weak var titleStackView: UIStackView!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var subTitleStackView: UIStackView!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfBirthDate: UITextField!
    
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var containerView: UIView!
    var pageType: Int!
    
    override func getPageName() -> String {
        return PageConstants.REGISTRATION_PAGE
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let radius = DimensionManager.getGeneralizedHeight1280x720(height: 20)
        containerView.layer.cornerRadius = radius
        setSpacing()
        setSize()
    }
    
    func setSpacing() {
        setSubTitleTopSpacing()
        setContentTopSpacing()
        setButtonTopSpacing()
        setButtonTopSpacing()
    }
    
    func setSize() {
        setTitleFont()
        setSubTitleFont()
        setBottomTitleFont()
        setFirstButtonSize()
        setChildTextSize()
        setDateOfBirthTextSize()
    }

    @IBAction func birthDateEditingDidBegin(_ sender: UITextField) {
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        datePickerView.minimumDate = Calendar.current.date(byAdding: .year, value: -8, to: Date() )
        datePickerView.maximumDate = Date()
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
        
        if StringUtil.isEmptyOrNullString(stringToCheck: tfName.text) {
            Toast(text: "Please Enter Your Child's Name").show()
        } else if StringUtil.isEmptyOrNullString(stringToCheck: tfBirthDate.text) {
            Toast(text: "Please Select Your Child's Birth Date").show()
            //showToast(message: "Please Select Your Child's Birth Date")
        } else {
            Toast(text: "Success").show()
            let givenChild = ChildInfo()
            givenChild.name = tfName.text
            givenChild.dob = tfBirthDate.text
            NavigationManager.openAvatarSelectionPage(mainControllerCommunicator: mainControllerCommunicator!, pageType: pageType, givenChild: givenChild)
            //showToast(message: "Success")
        }
    }
    
    // MARK: - Setting spacing
    func setContentTopSpacing() {
        contentStackView.layoutMargins.top = spacingConstant
        contentStackView.isLayoutMarginsRelativeArrangement = true
    }
    
    func setSubTitleTopSpacing() {
        subTitleStackView.layoutMargins.top = spacingConstant
        subTitleStackView.isLayoutMarginsRelativeArrangement = true
    }
    
    func setButtonTopSpacing() {
        buttonStackView.layoutMargins.top = spacingConstant
        buttonStackView.isLayoutMarginsRelativeArrangement = true
    }
    
    func setBottomTopSpacing() {
        bottomStackView.layoutMargins.top = spacingConstant
        bottomStackView.isLayoutMarginsRelativeArrangement = true
    }
    
    func setFirstButtonSize() {
        firstButton.heightAnchor.constraint(equalToConstant: DimensionManager.getGeneralizedHeight1280x720(height: 104)).isActive = true
        
        firstButton.widthAnchor.constraint(equalToConstant: DimensionManager.getGeneralizedWidth1280x720(width: 400)).isActive = true
        
    }
    
    func setChildTextSize() {
        tfName.heightAnchor.constraint(equalToConstant: DimensionManager.getGeneralizedHeight1280x720(height: 104)).isActive = true
        
        tfName.widthAnchor.constraint(equalToConstant: DimensionManager.getGeneralizedWidth1280x720(width: 450)).isActive = true
        //tfName.layer.cornerRadius = DimensionManager.getGeneralizedHeight1280x720(height: 52)
        
        DimensionManager.setTextSize1280x720(textField: tfName, size: DimensionManager.H4)
        
    }
    
    func setDateOfBirthTextSize() {
        
        tfBirthDate.rightViewMode = UITextFieldViewMode.always
        
        //let height = 3*tfBirthDate.bounds.height/4
        let image = UIImage(named: "calendar")
        let imageView = UIImageView(frame: CGRect(x:0, y:0, width: (image?.size.width)! + DimensionManager.getGeneralizedWidth1280x720(width: 30), height:(image?.size.height)!) )
        
        imageView.image = image
        imageView.contentMode = UIViewContentMode.center
        
        tfBirthDate.rightView = imageView
        
        tfBirthDate.heightAnchor.constraint(equalToConstant: DimensionManager.getGeneralizedHeight1280x720(height: 104)).isActive = true
        
        tfBirthDate.widthAnchor.constraint(equalToConstant: DimensionManager.getGeneralizedWidth1280x720(width: 450)).isActive = true
        //tfBirthDate.layer.cornerRadius = DimensionManager.getGeneralizedHeight1280x720(height: 52)
        
        DimensionManager.setTextSize1280x720(textField: tfBirthDate, size: DimensionManager.H4)
        
    }
    
    func setTitleFont() {
        DimensionManager.setTextSize1280x720(label: titleLabel, size: DimensionManager.H1)
    }
    
    func setSubTitleFont() {
        DimensionManager.setTextSize1280x720(label: subtitleLabel, size: DimensionManager.H2)
    }
    
    func setBottomTitleFont() {
        DimensionManager.setTextSize1280x720(label: bottomLabelOne, size: DimensionManager.H4)
        
        DimensionManager.setTextSize1280x720(label: bottomLabelTwo, size: DimensionManager.H4)
    }
}
