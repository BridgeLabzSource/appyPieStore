//
//  FreeTrialController.swift
//  APPYSTORE
//
//  Created by ios_dev on 18/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit

class BasePopUpController: BaseViewController {
    let spacingConstant = AppDelegate.DEVICE_HEIGHT/25
    
    @IBOutlet weak var crossButton: UIImageView!
    @IBOutlet weak var firstButton: CustomButton!
    @IBOutlet weak var bottomStackView: UIStackView!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var secondButton: CustomButton!
    @IBOutlet weak var centerStackView: UIStackView!
    @IBOutlet weak var subTitleStackView: UIStackView!
    @IBOutlet weak var titleStackView: UIStackView!
    @IBOutlet weak var rootStackView: UIStackView!
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var contentStackView: UIStackView!
    
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var centerEditText: UITextField!
    @IBOutlet weak var bottomLabel: UILabel!
    
    override internal func getPageName() -> String {
        return ""
    }
    
    override internal func getPageNameUniqueIdentifier() -> String {
        return ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let radius = DimensionManager.getGeneralizedHeight1280x720(height: 20)
        containerView.layer.cornerRadius = radius
        
        //titleStackView.layoutMargins = UIEdgeInsets(top: 30, left:0, bottom:0, right:0)
        //titleStackView.isLayoutMarginsRelativeArrangement = true
        //subTitleStackView.layoutMargins = UIEdgeInsets(top: 30, left:0, bottom:0, right:0)
        //subTitleStackView.isLayoutMarginsRelativeArrangement = true
        
        
        //firstButton.heightAnchor.constraint(equalToConstant: DimensionManager.getGeneralizedHeight1280x720(height: 104)).isActive = true
        
        //firstButton.widthAnchor.constraint(equalToConstant: DimensionManager.getGeneralizedWidth1280x720(width: 400)).isActive = true
        setListeners()
        
    }
    
    func setListeners() {
        let singleTapCrossButton = UITapGestureRecognizer(target: self, action: #selector(crossButtonClick))
        singleTapCrossButton.numberOfTapsRequired = 1 // you can change this value
        crossButton.isUserInteractionEnabled = true
        crossButton.addGestureRecognizer(singleTapCrossButton)
        
        firstButton.addTarget(self, action: #selector(firstButtonClick), for: .touchDown)
        secondButton.addTarget(self, action: #selector(secondButtonClick), for: .touchDown)
    }
    
    func crossButtonClick() {
        print("Basepopup crossButtonClick")
        assert(false, "must override method crossButtonClick")
    }
    
    func firstButtonClick() {
        print("Basepopup firstButtonClick")
        assert(false, "must override method firstButtonClick")
    }
    
    func secondButtonClick() {
        print("Basepopup secondButtonClick")
        assert(false, "must override method secondButtonClick")
    }
    
    // MARK: - Hiding viewa
    func hideTitleStackView() {
        titleStackView.isHidden = true
    }
    
    func hideTitleImage() {
        titleImage.isHidden = true
    }
    
    func hideSubTitleStackView() {
        subTitleStackView.isHidden = true
    }
    
    func hideContentStackView() {
        contentStackView.isHidden = true
    }
    
    func hideCenterStackView() {
        centerStackView.isHidden = true
    }
    
    func hideButtonStackView() {
        buttonStackView.isHidden = true
    }
    
    func hideBottomStackView() {
        bottomStackView.isHidden = true
    }
    
    func hideContentLabel() {
        contentLabel.isHidden = true
    }
    
    func hideFirstButton() {
        firstButton.isHidden = true
    }
    
    // MARK: - Setting values
    func setTitleTextLabel(_ title: String) {
        titleLabel.text = title
    }
    
    func setSubTitleTextLabel(_ title: String) {
        subtitleLabel.text = title
    }
    
    func setContentTextLabel(_ title: String) {
        contentLabel.text = title
    }
    
    func setImageContent(_ image: UIImage) {
        contentImage.image = image
    }
    
    func setFirstButtonTextLabel(_ title: String) {
        firstButton.setTitle(title, for: .normal)
    }
    
    func setSecondButtonTextLabel(_ title: String) {
        secondButton.setTitle(title, for: .normal)
    }
    
    func setBottomTextLabel(_ title: String) {
        bottomLabel.text = title
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
    
    func setCenterTopSpacing() {
        centerStackView.layoutMargins.top = spacingConstant
        centerStackView.isLayoutMarginsRelativeArrangement = true
    }
    
    func setButtonTopSpacing() {
        buttonStackView.layoutMargins.top = spacingConstant
        buttonStackView.isLayoutMarginsRelativeArrangement = true
    }
    
    func setBottomTopSpacing() {
        bottomStackView.layoutMargins.top = spacingConstant
        bottomStackView.isLayoutMarginsRelativeArrangement = true
    }
    
    // MARK: - Setting fonts
    func setTitleFont() {
        DimensionManager.setTextSize1280x720(label: titleLabel, size: DimensionManager.H1)
    }
    
    func setSubTitleFont() {
        DimensionManager.setTextSize1280x720(label: subtitleLabel, size: DimensionManager.H2)
    }
    
    func setBottomTitleFont() {
        DimensionManager.setTextSize1280x720(label: bottomLabel, size: DimensionManager.H4)
    }
    
    func setContentFont() {
        DimensionManager.setTextSize1280x720(label: contentLabel, size: DimensionManager.H2)
    }
    
    func setFirstButtonSize() {
        firstButton.heightAnchor.constraint(equalToConstant: DimensionManager.getGeneralizedHeight1280x720(height: 104)).isActive = true
        
        firstButton.widthAnchor.constraint(equalToConstant: DimensionManager.getGeneralizedWidth1280x720(width: 400)).isActive = true
    }
    
    func setSecondButtonSize() {
        secondButton.heightAnchor.constraint(equalToConstant: DimensionManager.getGeneralizedHeight1280x720(height: 104)).isActive = true
        
        secondButton.widthAnchor.constraint(equalToConstant: DimensionManager.getGeneralizedWidth1280x720(width: 400)).isActive = true
    }
    
    func setCenterTextSize() {
        
        centerEditText.heightAnchor.constraint(equalToConstant: DimensionManager.getGeneralizedHeight1280x720(height: 104)).isActive = true
        
        centerEditText.widthAnchor.constraint(equalToConstant: DimensionManager.getGeneralizedWidth1280x720(width: 600)).isActive = true
        centerEditText.layoutIfNeeded()
        centerEditText.layer.cornerRadius = centerEditText.frame.height/2
        
    }
    
    func setContentImageHeight() {
        contentImage.heightAnchor.constraint(equalToConstant: DimensionManager.getGeneralizedHeight1280x720(height: 200)).isActive = true
        //contentImage.clipsToBounds = true
        //contentImage.layoutIfNeeded()
    }
    /*
     //buttonStackView.layoutMargins = UIEdgeInsets(top: 0, left:50, bottom:0, right:50)
     //buttonStackView.isLayoutMarginsRelativeArrangement = true
     //buttonStackView.heightAnchor.constraint(equalToConstant: 200)
     /*
     DimensionManager.setDimension1280x720(view: firstButton, width: DimensionManager.getGeneralizedWidth1280x720(width: 400), height: DimensionManager.getGeneralizedHeight1280x720(height: 104))
     */
     /*
     let topConstraint = NSLayoutConstraint(
     item: titleStackView,
     attribute: .topMargin,
     relatedBy: .equal,
     toItem: rootStackView,
     attribute: .topMargin,
     multiplier:1,
     constant: 0)
     titleStackView.translatesAutoresizingMaskIntoConstraints = true
     titleStackView.addConstraint(topConstraint)
     */
     */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
