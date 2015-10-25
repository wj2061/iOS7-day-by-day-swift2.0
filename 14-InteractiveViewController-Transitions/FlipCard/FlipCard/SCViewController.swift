//
//  SCViewController.swift
//  FlipCard
//
//  Created by wj on 15/10/25.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class SCViewController: UIViewController,UIViewControllerTransitioningDelegate{
    
    let flipAnimation = SCFlipAnimation()
    let animationInteractor = SCFlipAnimationInteractor()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        if !view.window!.gestureRecognizers!.contains(animationInteractor.gestureRecogniser!){
            view.window!.addGestureRecognizer(animationInteractor.gestureRecogniser!)
        }
        animationInteractor.presentingVC = self
    }
    

    //MARK: - UIViewControllerTransitioningDelegate
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        flipAnimation.dismissal = false
        return flipAnimation
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        flipAnimation.dismissal = true
        return flipAnimation
    }
    
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return  animationInteractor.interactionInProgress ? animationInteractor : nil
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return  animationInteractor.interactionInProgress ? animationInteractor : nil

    }
 
    
    //MARK: - SCInteractiveTransitionViewControllerDelegate methods
    override func proceedToNextViewController(){
        performSegueWithIdentifier("model", sender: self)
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "model"{
            if let vc = segue.destinationViewController as? SCModelViewController{
                vc.transitioningDelegate = self
                vc.interactor = animationInteractor
                
            }
        }

    }

}
