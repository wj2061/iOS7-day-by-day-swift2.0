//
//  SCItemBehaviorManager.swift
//  SpringCarousel
//
//  Created by WJ on 15/10/16.
//  Copyright © 2015年 wj. All rights reserved.
//

import Foundation
import UIKit

class SCItemBehaviorManager{
    let gravityBehavior = UIGravityBehavior()
    
    let collisionBehavior = UICollisionBehavior()
    
    var attachmentBehaviors = [NSIndexPath:UIAttachmentBehavior]()
    
    let animator:UIDynamicAnimator
    
    init(animat:UIDynamicAnimator){
        animator=animat
        gravityBehavior.magnitude = 0.3
        
        collisionBehavior.collisionMode = UICollisionBehaviorMode.Boundaries
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        let itemBehavior = UIDynamicItemBehavior()
        itemBehavior.elasticity = 1.0
        collisionBehavior.addChildBehavior(itemBehavior)
        
        animator.addBehavior(gravityBehavior)
        animator.addBehavior(collisionBehavior)
    }
    
    //MARK: - API methods
    func addItem(item:UICollectionViewLayoutAttributes, anchor:CGPoint)
    {
        let attachmentBehavior = UIAttachmentBehavior(item: item, attachedToAnchor: anchor)
        attachmentBehavior.damping = 0.5
        attachmentBehavior.frequency = 0.8
        attachmentBehavior.length = 0
        
        animator.addBehavior(attachmentBehavior)
        attachmentBehaviors[item.indexPath] = attachmentBehavior
        
        gravityBehavior.addItem(item)
        collisionBehavior.addItem(item)
    }
    
    func removeItemAtIndexPath(indexpath:NSIndexPath)
    {
        if let attachmentBehavior = attachmentBehaviors[indexpath]{
            animator.removeBehavior(attachmentBehavior)
        }
        for  attr in gravityBehavior.items {
            if let colAttr  = attr as? UICollectionViewLayoutAttributes{
                if colAttr.indexPath.isEqual(indexpath){
                    gravityBehavior.removeItem(colAttr)
                }
            }
        }
        
        for attr in collisionBehavior.items{
            if let colAttr = attr as? UICollectionViewLayoutAttributes{
                if colAttr.indexPath.isEqual(indexpath){
                    collisionBehavior.removeItem(colAttr)
                }
            }
        }
        attachmentBehaviors.removeValueForKey(indexpath)
    }
    
    func updateItemCollection(items:[UICollectionViewLayoutAttributes]){
        var toRemove = Set( attachmentBehaviors.keys)
        let itemSet =  Set( items.map{$0.indexPath} )
        toRemove  = toRemove.subtract(itemSet)
        
        for indexPath in toRemove{
            removeItemAtIndexPath(indexPath)
        }
        
        let existingIndexPaths = currentlyManagedItemIndexPaths()
        for attr in items{
            var alreadyExists = false
            for  indexpath in existingIndexPaths{
                if indexpath.isEqual(attr.indexPath){
                    alreadyExists = true
                }
            }
            if !alreadyExists {
                addItem(attr, anchor: attr.center)
            }
        }
    }
    
    func currentlyManagedItemIndexPaths()->[NSIndexPath]{
        let keys = Array(attachmentBehaviors.keys)
        return keys.sort{$0.item < $1.item}
    }
    
}