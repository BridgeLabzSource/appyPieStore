//
//  LoginFailurePage.swift
//  APPYSTORE
//
//  Created by ios_dev on 03/05/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class LoginFailurePage: BasePopUpController, UITextViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showSubTitleLabel()
        showCenterEditText()
        showErrorImage()
        showErrorLabel()
        showFirstButton()
        showBottomLabelOne()
        showBottomLabelTwo()
        
        //showContentImage()
        
        setStringValues()
        setLabelTwoWithAttributedString()
    }
    
    func setLabelTwoWithAttributedString() {
        let text = NSMutableAttributedString(string: "Already have an account? ")
        text.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 12), range: NSMakeRange(0, text.length))
        
        let selectablePart = NSMutableAttributedString(string: "Sign in!")
        selectablePart.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 12), range: NSMakeRange(0, selectablePart.length))
        // Add an underline to indicate this portion of text is selectable (optional)
        selectablePart.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0,selectablePart.length))
        selectablePart.addAttribute(NSUnderlineColorAttributeName, value: UIColor.black, range: NSMakeRange(0, selectablePart.length))
        // Add an NSLinkAttributeName with a value of an url or anything else
        selectablePart.addAttribute(NSLinkAttributeName, value: "signin", range: NSMakeRange(0,selectablePart.length))
        
        // Combine the non-selectable string with the selectable string
        text.append(selectablePart)
        
        // Center the text (optional)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        text.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, text.length))
        
        // To set the link text color (optional)
        //bottomLabelTwo.linkTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor(), NSFontAttributeName: UIFont.systemFontOfSize(12)]
        
        // Set the text view to contain the attributed text
        bottomLabelTwo.attributedText = text
        // Disable editing, but enable selectable so that the link can be selected
        //bottomLabelTwo.editable = false
        //bottomLabelTwo.selectable = true
        // Set the delegate in order to use textView(_:shouldInteractWithURL:inRange)
        //bottomLabelTwo.delegate = self
    }
    
    func textView(bottomLabelTwo: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
        
        // **Perform sign in action here**
        
        return false
    }
    
    func setStringValues() {
        setSubTitleTextLabel("Please enter your registered mobile number")
        setImageError(UIImage(named: "cart")!)
        setErrorTextLabel("We are unable to recognize your number")
        setFirstButtonTextLabel("Try Again")
        //setBottomTextLabelOne("OR")
        //setBottomTextLabelTwo("Register with xxxxxxxxx")
    }
    
    override func firstButtonClick() {
        self.mainControllerCommunicator?.showProgressBar()
        //todo email id
        LoginParser().parse(params: HttpRequestBuilder.getLoginParameters(method: LoginParser.METHOD_NAME, msisdn: centerEditText.text!, pageId: "login", emailId: ""), completion: {
            statusType, result in
            
            self.mainControllerCommunicator?.hideProgressBar()
            if statusType == BaseParser.REQUEST_SUCCESS {
                NavigationUtil.navigateAsPerChildSize(mainControllerCommunicator: self.mainControllerCommunicator!)
            } else if statusType == BaseParser.REQUEST_FAILURE {
                
            } else if statusType == BaseParser.CONNECTION_ERROR {
                
            }
        })
        
    }
}
