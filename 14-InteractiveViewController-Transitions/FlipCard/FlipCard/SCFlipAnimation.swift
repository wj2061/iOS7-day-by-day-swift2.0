//
//  SCFlipAnimation.swift
//  FlipCard
//
//  Created by wj on 15/10/25.
//  Copyright © 2015年 wj. All rights reserved.
//

//import Foundation
import UIKit
class SCFlipAnimation:NSObject, UIViewControllerAnimatedTransitioning{
    var  dismissal = false
    
    
    
    //MARK: - UIViewControllerAnimatedTransitioning
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC   = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        let containerView = transitionContext.containerView()!
        let fromView = fromVC.view
        let toView   = toVC.view
        
        containerView.addSubview(toView)
        
        let initialFrame = transitionContext.initialFrameForViewController(fromVC)
        fromView.frame = initialFrame
        toView.frame = initialFrame
        
        var transform = CATransform3DIdentity
        transform.m34 = -1 / CGRectGetHeight(initialFrame)
        containerView.layer.sublayerTransform = transform
        
        let direction:CGFloat = dismissal ? -1.0 : 1.0
        toView.layer.transform = CATransform3DMakeRotation(-direction * CGFloat( M_PI_2 ) , 1, 0, 0)
        UIView.animateKeyframesWithDuration(transitionDuration(transitionContext), delay: 0, options: [], animations: { () -> Void in
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.5, animations: { () -> Void in
                fromView.layer.transform = CATransform3DMakeRotation(direction * CGFloat( M_PI_2 ), 1, 0, 0)
            })
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.5, animations: { () -> Void in
                toView.layer.transform = CATransform3DMakeRotation(0, 1, 0, 0)
            })
            }) { (_ ) -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
    
    
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1
    }
}