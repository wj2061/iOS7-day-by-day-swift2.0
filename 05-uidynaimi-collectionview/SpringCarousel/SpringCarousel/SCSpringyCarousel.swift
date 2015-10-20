//
//  SCSpringyCarousel.swift
//  SpringCarousel
//
//  Created by WJ on 15/10/16.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class SCSpringyCarousel: UICollectionViewFlowLayout {
//    let  itemSize:CGSize
    lazy var  dynamicAnimator:UIDynamicAnimator = UIDynamicAnimator(collectionViewLayout: self)
    var  behaviorManager:SCItemBehaviorManager!
    
    init(size:CGSize){
        super.init()
        itemSize = size
        dynamicAnimator = UIDynamicAnimator(collectionViewLayout: self)
        behaviorManager = SCItemBehaviorManager(animat: dynamicAnimator)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   // MARK: - Overridden methods
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        let scrollDelta = newBounds.origin.x-(collectionView?.bounds.origin.x)!
        
        let touchLocation = collectionView!.panGestureRecognizer.locationInView(collectionView!)
        
        for  behavior in Array( behaviorManager.attachmentBehaviors.values ) {
            let  anchorPoint = behavior.anchorPoint
            let  distFromTouch = abs(anchorPoint.x-touchLocation.x)
            
            if let attr = behavior.items.first as? UICollectionViewLayoutAttributes{
                var center = attr.center
                let scaleFactor = min(1, distFromTouch/500)
                
                center.x += scrollDelta * scaleFactor
                attr.center = center
                
                dynamicAnimator.updateItemUsingCurrentState(attr )
            }
        }
        return false
    }
    
    override func prepareLayout(){
        UIView.setAnimationsEnabled(false )
        
        sectionInset = UIEdgeInsets(top: CGRectGetHeight(collectionView!.bounds ) - itemSize.height, left: 0, bottom: 0, right: 0)
        super.prepareLayout()
        
        var expandedViewPort = collectionView!.bounds
        expandedViewPort.origin.x -= 2 * itemSize.width
        expandedViewPort.size.width += 4 * itemSize.width
        
        let currentItems =  super.layoutAttributesForElementsInRect(expandedViewPort)
        
        behaviorManager.updateItemCollection(currentItems!)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return dynamicAnimator.itemsInRect(rect) as? [UICollectionViewLayoutAttributes]
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return dynamicAnimator.layoutAttributesForCellAtIndexPath(indexPath)
        
    }
    
    //MARK: - Item insertion methods
    
    override func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return dynamicAnimator.layoutAttributesForCellAtIndexPath(itemIndexPath)
    }
    
    override func prepareForCollectionViewUpdates(updateItems: [UICollectionViewUpdateItem]) {
        for updateItem in updateItems{
            if updateItem.updateAction == UICollectionUpdateAction.Insert{
                resetItemSpringsForInsertAtIndexPath(updateItem.indexPathAfterUpdate)
                
                if let attr = super.initialLayoutAttributesForAppearingItemAtIndexPath(updateItem.indexPathAfterUpdate){
                    var center = attr.center
                    let contensize = collectionView!.contentSize
                    center.y -= contensize.height - CGRectGetHeight(attr.bounds)
                    
                    if let insertionPointAttr = layoutAttributesForItemAtIndexPath(updateItem.indexPathAfterUpdate){
                       insertionPointAttr.center = center
                       dynamicAnimator.updateItemUsingCurrentState(insertionPointAttr)
                    }
                }
            }
        }
    }
    
    func resetItemSpringsForInsertAtIndexPath(index:NSIndexPath){
        let  items = behaviorManager.currentlyManagedItemIndexPaths()
        
        for k in 0..<items.count-1{
            let fromindex = items[k+1]
            let toindex = items[k]
            
            if toindex.item > index.item{
                let toitem = layoutAttributesForItemAtIndexPath(toindex)!
                let fromitem = layoutAttributesForItemAtIndexPath(fromindex)!
                
                toitem.center = fromitem.center
                dynamicAnimator.updateItemUsingCurrentState(toitem)
            }
        }
    }
}
