//
//  FreeTrialController.swift
//  APPYSTORE
//
//  Created by ios_dev on 18/04/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BasePopUpController: BaseViewController, UITextViewDelegate {
    
    static let POPUP_CORNER_RADIUS = DimensionManager.getGeneralizedHeight1280x720(height: 24)
    let spacingConstant = AppDelegate.DEVICE_HEIGHT/25
    var progressView: NVActivityIndicatorView?
    
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var rootStackView: UIStackView!
    
    @IBOutlet weak var crossButton: UIImageView!
    
    @IBOutlet weak var titleStackView: UIStackView!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subTitleStackView: UIStackView!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var centerStackView: UIStackView!
    @IBOutlet weak var centerEditText: UITextField!
    
    @IBOutlet weak var errorStackView: UIStackView!
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var firstButton: CustomButton!
    @IBOutlet weak var secondButton: CustomButton!
    
    @IBOutlet weak var bottomStackView: UIStackView!
    @IBOutlet weak var tvBottom: UITextView!
    
    override internal func getPageName() -> String {
        return ""
    }
    
    override internal func getPageNameUniqueIdentifier() -> String {
        return ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        containerView.layer.cornerRadius = BasePopUpController.POPUP_CORNER_RADIUS
        containerView.showShadowRightBottom()
        
        setListeners()
        setFontSize()
        setTopSpacing()
        initProgressBar()
    }
    
    private func initProgressBar() {
        let width = DimensionManager.getGeneralizedWidth1280x720(width: 210)
        let height = DimensionManager.getGeneralizedHeight1280x720(height: 70)
        let frame = CGRect(x: CGFloat(buttonStackView.frame.width/2 - width/2), y: 0, width: width, height: height)
        progressView = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.ballPulse, color: UIColor.orange, padding: CGFloat(0))
    }
    
    func showProgress() {
        progressView?.startAnimating()
        buttonStackView.addSubview(progressView!)
        buttonStackView.bringSubview(toFront: progressView!)
    }
    
    func hideProgress() {
        progressView?.stopAnimating()
        progressView?.removeFromSuperview()
    }
    
    func setLabelTwoWithAttributedString(_ text: String, _ clickablePart: String?) {
        let text = NSMutableAttributedString(string: text)
        text.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 12), range: NSMakeRange(0, text.length))
        
        if(clickablePart != nil && (clickablePart?.characters.count)! > 0) {
            let selectablePart = NSMutableAttributedString(string: clickablePart!)
            selectablePart.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 12), range: NSMakeRange(0, selectablePart.length))
            // Add an underline to indicate this portion of text is selectable (optional)
            selectablePart.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0,selectablePart.length))
            selectablePart.addAttribute(NSUnderlineColorAttributeName, value: UIColor.blue, range: NSMakeRange(0, selectablePart.length))
            // Add an NSLinkAttributeName with a value of an url or anything else
            selectablePart.addAttribute(NSLinkAttributeName, value: "click", range: NSMakeRange(0, selectablePart.length))
            
            // Combine the non-selectable string with the selectable string
            text.append(selectablePart)
        }
        // Center the text (optional)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        text.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, text.length))
        
        // To set the link text color (optional)
        tvBottom.linkTextAttributes = [NSForegroundColorAttributeName:UIColor.blue, NSFontAttributeName: UIFont.systemFont(ofSize: 12)]
        
        // Set the text view to contain the attributed text
        tvBottom.attributedText = text
        // Disable editing, but enable selectable so that the link can be selected
        tvBottom.isEditable = false
        tvBottom.isSelectable = true
        // Set the delegate in order to use textView(_:shouldInteractWithURL:inRange)
        tvBottom.delegate = self
        
        //tvBottom.isUserInteractionEnabled = true
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        onBottomTextClick()
        return false
    }
    
    func onBottomTextClick() {
        
    }
    
    func setListeners() {
        let singleTapCrossButton = UITapGestureRecognizer(target: self, action: #selector(crossButtonClick))
        singleTapCrossButton.numberOfTapsRequired = 1
        crossButton.isUserInteractionEnabled = true
        crossButton.addGestureRecognizer(singleTapCrossButton)
        
        firstButton.addTarget(self, action: #selector(firstButtonClick), for: .touchDown)
        secondButton.addTarget(self, action: #selector(secondButtonClick), for: .touchDown)
    }
    
    func setFontSize() {
        setTitleFont()
        setSubTitleFont()
        setErrorFontSize()
        setBottomTitleFont()
        setContentFont()
        setFirstButtonSize()
        setSecondButtonSize()
        setCenterTextSize()
        setContentImageHeight()
    }
    
    func setTopSpacing() {
        setSubTitleTopSpacing()
        setCenterTopSpacing()
        setContentTopSpacing()
        setErrorTopSpacing()
        setButtonTopSpacing()
        setBottomTopSpacing()
    }
    
    func crossButtonClick() {
        print("Basepopup crossButtonClick")
        //assert(false, "must override method crossButtonClick")
        mainControllerCommunicator?.performBackButtonClick(self)
    }
    
    func firstButtonClick() {
        print("Basepopup firstButtonClick")
        assert(false, "must override method firstButtonClick")
    }
    
    func secondButtonClick() {
        print("Basepopup secondButtonClick")
        assert(false, "must override method secondButtonClick")
    }
    
    // MARK: - Showing viewa
    func showCrossButton() {
        crossButton.isHidden = false
    }
    
    func showTitleStackView() {
        titleStackView.isHidden = false
    }
    
    func showTitleImage() {
        showTitleStackView()
        titleImage.isHidden = false
    }
    
    func showTitleLabel() {
        showTitleStackView()
        titleLabel.isHidden = false
    }
    
    func showSubTitleStackView() {
        subTitleStackView.isHidden = false
    }
    
    func showSubTitleLabel() {
        showSubTitleStackView()
        subtitleLabel.isHidden = false
    }
    
    func showContentStackView() {
        contentStackView.isHidden = false
    }
    
    func showContentImage() {
        showContentStackView()
        contentImage.isHidden = false
    }
    
    func showContentLabel() {
        showContentStackView()
        contentLabel.isHidden = false
    }
    
    func showCenterStackView() {
        centerStackView.isHidden = false
    }
    
    func showCenterEditText() {
        showCenterStackView()
        centerEditText.isHidden = false
    }
    
    func showErrorStackView() {
        errorStackView.isHidden = false
    }
    
    func showErrorImage() {
        showErrorStackView()
        errorImage.isHidden = false
    }
    
    func showErrorLabel() {
        showErrorStackView()
        errorLabel.isHidden = false
    }
    
    func showButtonStackView() {
        buttonStackView.isHidden = false
    }
    
    func showFirstButton() {
        showButtonStackView()
        firstButton.isHidden = false
    }
    
    func showSecondButton() {
        showButtonStackView()
        secondButton.isHidden = false
    }
    
    func hideFirstButton() {
        firstButton.isHidden = true
    }
    
    func hideSecondButton() {
        secondButton.isHidden = true
    }
    
    func showBottomStackView() {
        bottomStackView.isHidden = false
    }
    
    func showBottomTextView() {
        showBottomStackView()
        tvBottom.isHidden = false
        tvBottom.widthAnchor.constraint(equalToConstant: AppDelegate.DEVICE_WIDTH*0.8).isActive = true
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
    
    func setImageError(_ image: UIImage) {
        errorImage.image = image
    }
    
    func setErrorTextLabel(_ title: String) {
        errorLabel.text = title
    }
    
    func setCenterEditTextValue(_ title: String) {
        centerEditText.text = title
    }
    
    func setCenterEditTextPlaceholder(_ title: String) {
        centerEditText.placeholder = title
    }
    
    func setFirstButtonTextLabel(_ title: String) {
        firstButton.setTitle(title, for: .normal)
    }
    
    func setSecondButtonTextLabel(_ title: String) {
        secondButton.setTitle(title, for: .normal)
    }
    
    func setBottomTextView(_ text: String, _ clickablePart: String?) {
        setLabelTwoWithAttributedString(text, clickablePart)
    }
    
    // MARK: - Setting spacing
    
    func setSubTitleTopSpacing() {
        subTitleStackView.layoutMargins.top = spacingConstant
        subTitleStackView.isLayoutMarginsRelativeArrangement = true
    }
    
    func setContentTopSpacing() {
        contentStackView.layoutMargins.top = spacingConstant
        contentStackView.isLayoutMarginsRelativeArrangement = true
    }
    
    func setCenterTopSpacing() {
        centerStackView.layoutMargins.top = spacingConstant
        centerStackView.isLayoutMarginsRelativeArrangement = true
    }
    
    func setErrorTopSpacing() {
        errorStackView.layoutMargins.top = spacingConstant
        errorStackView.isLayoutMarginsRelativeArrangement = true
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
        DimensionManager.setTextSize1280x720(textView: tvBottom, size: DimensionManager.H3)
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
        centerEditText.layer.cornerRadius = DimensionManager.getGeneralizedHeight1280x720(height: 52)
        
    }
    
    func setErrorFontSize() {
        DimensionManager.setTextSize1280x720(label: errorLabel, size: DimensionManager.H3)
    }
    
    func setContentImageHeight() {
        contentImage.heightAnchor.constraint(equalToConstant: DimensionManager.getGeneralizedHeight1280x720(height: 200)).isActive = true
    }
}
