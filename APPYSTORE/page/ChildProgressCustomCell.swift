//
//  ChildProgressCustomCell.swift
//  
//
//  Created by BridgeLabz on 04/05/17.
//
//

import UIKit
var indexValue:Int = 0
class ChildProgressCustomCell: BaseCard{
    

    @IBOutlet weak var topProgressBarViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var topProgressBarView: UIView!
    @IBOutlet weak var buttomProgressBarView: UIView!
    @IBOutlet var categoryNameLabel: UILabel!
    @IBOutlet var transCountLabel: UILabel!
    
    let progressBarColorArray = [UIColor.red,UIColor.blue,UIColor.black,UIColor.green,UIColor.brown,UIColor.gray,UIColor.orange,UIColor.yellow,UIColor.cyan,UIColor.purple,UIColor.magenta]
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func fillCard(model: BaseModel) {
        
        let childProgressModel = model as! ChildProgressModel
            categoryNameLabel.text  = childProgressModel.category_name
            transCountLabel.text = childProgressModel.trans_count
        
        let trans_count = childProgressModel.trans_count
        getCustomProgressBarFilled(trans_count: trans_count)
    }
    override func draw(_ rect: CGRect) {
        
         DimensionManager.setTextSize1280x720(label: categoryNameLabel, size: DimensionManager.H3)
         DimensionManager.setTextSize1280x720(label: transCountLabel, size: DimensionManager.H3)
        setCustomProgressBar()
        setRandomColorForProgressBar()
        
    }
    
    // Here for custom progress bar 2 UIView have taken,
    // 1 view is fixed and other view is flexible as per the percentage
   
    func setCustomProgressBar(){
        buttomProgressBarView.layer.cornerRadius = (buttomProgressBarView.frame.size.height / 2)
        topProgressBarView.layer.cornerRadius = (topProgressBarView.frame.size.height / 2)
        buttomProgressBarView.layer.borderWidth = 1
        buttomProgressBarView.layer.borderColor = UIColor.gray.cgColor
    }
    
    
    func getCustomProgressBarFilled(trans_count  : String){
        let progressValue = CGFloat(Int(trans_count)!)
        let value = buttomProgressBarView.frame.size.width/100
        let progressBarPercentage = progressValue * value
        topProgressBarViewWidthConstraint.constant = progressBarPercentage
    }
    
    
   func  setRandomColorForProgressBar()
   {
        if indexValue  >= 10
          {
            indexValue = 0
          }
        topProgressBarView.backgroundColor = progressBarColorArray[indexValue]
        indexValue = indexValue + 1
   }
    
}
