//
//  SCViewController.swift
//  ExtendedLayout
//
//  Created by WJ on 15/10/30.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class SCViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewbox = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        viewbox.backgroundColor = UIColor.blueColor()
        view.addSubview(viewbox)
        edgesForExtendedLayout = UIRectEdge.None
    }


    



}
