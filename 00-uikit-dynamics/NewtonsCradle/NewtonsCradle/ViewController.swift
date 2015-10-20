//
//  ViewController.swift
//  NewtonsCradle
//
//  Created by WJ on 15/10/13.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let newtownsView = SCNewtonsCradleView(frame: view.frame)
        view.addSubview(newtownsView)
    }
}

