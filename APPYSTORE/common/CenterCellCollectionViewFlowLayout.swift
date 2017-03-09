//
//  CenterCellCollectionViewFlowLayout.swift
//  APPYSTORE
//
//  Created by BridgeLabz on 09/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import UIKit
import Foundation

class CenterCellCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    
//    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
//        
//        var attributesToReturn:[UICollectionViewLayoutAttributes] = super.layoutAttributesForElementsInRect(rect) as! [UICollectionViewLayoutAttributes]
//        
//        for i in 0  ..< attributesToReturn.count 
//        {
//            let currentLayoutAttributes: UICollectionViewLayoutAttributes = attributesToReturn[i]
//            let maximumSpacing: CGFloat = 50
//            let origin: CGFloat
//            if i - 1 >= 0 {
//                let previousLayoutAttributes = attributesToReturn[i - 1]
//                origin = previousLayoutAttributes.frame.maxX
//            } else {
//                origin = 0
//            }
//            
//            if origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width
//            {
//                var frame: CGRect = currentLayoutAttributes.frame
//                frame.origin.x = origin + maximumSpacing
//                currentLayoutAttributes.frame = frame
//            }
//        }
//        
//        return attributesToReturn
//        
//    }
    
//    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
//        
//        if let cv = self.collectionView {
//            
//            let cvBounds = cv.bounds
//            let halfWidth = cvBounds.size.width * 0.5;
//            let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidth;
//            
//            if let attributesForVisibleCells = self.layoutAttributesForElementsInRect(cvBounds) as? [UICollectionViewLayoutAttributes] {
//                
//                var candidateAttributes : UICollectionViewLayoutAttributes?
//                for attributes in attributesForVisibleCells {
//                    
//                    // == Skip comparison with non-cell items (headers and footers) == //
//                    if attributes.representedElementCategory != UICollectionElementCategory.Cell {
//                        continue
//                    }
//                    
//                    if let candAttrs = candidateAttributes {
//                        
//                        let a = attributes.center.x - proposedContentOffsetCenterX
//                        let b = candAttrs.center.x - proposedContentOffsetCenterX
//                        
//                        if fabsf(Float(a)) < fabsf(Float(b)) {
//                            candidateAttributes = attributes;
//                        }
//                        
//                    }
//                    else { // == First time in the loop == //
//                        
//                        candidateAttributes = attributes;
//                        continue;
//                    }
//                    
//                    
//                }
//                
//                return CGPoint(x : candidateAttributes!.center.x - halfWidth, y : proposedContentOffset.y);
//                
//            }
//            
//        }
//        
//        // Fallback
//        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
//    }

    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalOffset = proposedContentOffset.x
        let targetRect = CGRect(origin: CGPoint(x: proposedContentOffset.x, y: 0), size: self.collectionView!.bounds.size)
        
        for layoutAttributes in super.layoutAttributesForElements(in: targetRect)! {
            let itemOffset = layoutAttributes.frame.origin.x
            if (abs(itemOffset - horizontalOffset) < abs(offsetAdjustment)) {
                offsetAdjustment = itemOffset - horizontalOffset
            }
        }
        
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
    
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        targetContentOffset.pointee = scrollView.contentOffset
//        let pageWidth:Float = Float(self.view.bounds.width)
//        let minSpace:Float = 10.0
//        var cellToSwipe:Double = Double(Float((scrollView.contentOffset.x))/Float((pageWidth+minSpace))) + Double(0.5)
//        if cellToSwipe < 0 {
//            cellToSwipe = 0
//        } else if cellToSwipe >= Double(self.articles.count) {
//            cellToSwipe = Double(self.articles.count) - Double(1)
//        }
//        let indexPath:IndexPath = IndexPath(row: Int(cellToSwipe), section:0)
//        self.collectionView?.scrollToItem(at:indexPath, at: UICollectionViewScrollPosition.left, animated: true)
//    }
    
    
    //    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    //        targetContentOffset.pointee = scrollView.contentOffset
    //        let pageWidth:Float = Float(self.view.bounds.width)
    //        let minSpace:Float = 10.0
    //        var cellToSwipe:Double = Double(Float((scrollView.contentOffset.x))/Float((pageWidth+minSpace))) + Double(0.5)
    //        if cellToSwipe < 0 {
    //            cellToSwipe = 0
    //        } else if cellToSwipe >= Double(self.dataList.count) {
    //            cellToSwipe = Double(self.dataList.count) - Double(1)
    //        }
    //        let indexPath:IndexPath = IndexPath(row: Int(cellToSwipe), section:0)
    //        self.collectionView?.scrollToItem(at:indexPath, at: UICollectionViewScrollPosition.left, animated: true)
    //    }
    
    //working
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let pageWidth: Float = Float(self.collectionView.frame.width / 3) //480 + 50
//        // width + space
//        let currentOffset: Float = Float(scrollView.contentOffset.x)
//        print("currentOffset:  \(currentOffset)")
//        let targetOffset: Float = Float(targetContentOffset.pointee.x)
//        var newTargetOffset: Float = 0
//        if targetOffset > currentOffset {
//            newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth
//        }
//        else {
//            newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth
//        }
//        if newTargetOffset < 0 {
//            newTargetOffset = 0
//        }
//        else if (newTargetOffset > Float(scrollView.contentSize.width)){
//            newTargetOffset = Float(Float(scrollView.contentSize.width))
//        }
//        
//        targetContentOffset.pointee.x = CGFloat(currentOffset)
//        scrollView.setContentOffset(CGPoint(x: CGFloat(newTargetOffset), y: scrollView.contentOffset.y), animated: true)
//        
//    }

}
