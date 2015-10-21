//
//  SCFadeTransition.swift
//  Fader
//
//  Created by WJ on 15/10/21.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class SCFadeTransition: NSObject ,UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 2.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        // Get the two view controllers
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        let containerView = transitionContext.containerView()
        
        containerView?.addSubview(fromVC.view)
        containerView?.addSubview(toVC.view)
        toVC.view.alpha = 0.0
        
        UIView.animateWithDuration(transitionDuration(transitionContext),
            animations: { () -> Void in
                toVC.view.alpha = 1.0
            }) { (_) -> Void in
                fromVC.view.removeFromSuperview()
                transitionContext.completeTransition(true )
        }
    }
   
    
}
