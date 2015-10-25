//
//  SCFlipAnimationInteractor.swift
//  FlipCard
//
//  Created by wj on 15/10/25.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class SCFlipAnimationInteractor: UIPercentDrivenInteractiveTransition {
    var gestureRecogniser : UIPanGestureRecognizer?
    var interactionInProgress = false
    weak var presentingVC:UIViewController?
    
    override init() {
        super.init()
        gestureRecogniser = UIPanGestureRecognizer(target: self, action: Selector("handlePan:"))
    }
    
    //MARK: - Gesture recognition
    func handlePan(gesture:UIPanGestureRecognizer){
        let translation = gesture.translationInView(gesture.view!)
        let percentage = fabs ( translation.y / CGRectGetHeight(gesture.view!.bounds) )
        
        switch gesture.state{
        case .Began:
            interactionInProgress = true
            presentingVC?.proceedToNextViewController()
        case .Changed:
            updateInteractiveTransition(percentage)
        case .Ended:
            if percentage < 0.5 {
                cancelInteractiveTransition()
            }else {
                finishInteractiveTransition()
            }
            interactionInProgress = false
        case .Cancelled:
            cancelInteractiveTransition()
            interactionInProgress = false
        default:
            break
        }
    }
    

}


protocol SCInteractiveTransitionViewControllerDelegate{
    func proceedToNextViewController()
}

extension UIViewController:SCInteractiveTransitionViewControllerDelegate{
    func proceedToNextViewController(){
        
    }

}