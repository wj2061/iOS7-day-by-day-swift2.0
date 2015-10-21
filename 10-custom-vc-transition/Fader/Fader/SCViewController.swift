//
//  SCViewController.swift
//  Fader
//
//  Created by WJ on 15/10/21.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class SCViewController: UINavigationController {
    let  navDelegate = SCNavControllerDelegate()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = navDelegate
    }
}
