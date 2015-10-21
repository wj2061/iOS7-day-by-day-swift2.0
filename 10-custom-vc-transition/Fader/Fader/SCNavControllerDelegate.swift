//
//  SCNavControllerDelegate.swift
//  Fader
//
//  Created by WJ on 15/10/21.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class SCNavControllerDelegate: NSObject,UINavigationControllerDelegate  {
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return SCFadeTransition()
    }
}
