//
//  SCScrollViewController.swift
//  ExtendedLayout
//
//  Created by WJ on 15/10/30.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class SCScrollViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let boxHeight:CGFloat = 100
        let numberBoxes = 20
        scrollView.contentSize = CGSize(width: CGRectGetWidth(view.frame), height: CGFloat(numberBoxes)*boxHeight)
        
        for i in 0..<numberBoxes{
            let box = UIView(frame: CGRect(x: 0.0, y: CGFloat(i)*boxHeight, width:  CGRectGetWidth(view.frame), height: boxHeight))
            if i%2 == 0{
                box.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.9)
            }else{
                box.backgroundColor = UIColor.greenColor().colorWithAlphaComponent(0.9)
            }
            
            let label  = UILabel(frame: box.bounds)
            label.text = "\(i)"
            label.textAlignment = NSTextAlignment.Center
            label.font = UIFont.systemFontOfSize(20.0)
            box.addSubview(label)
            scrollView.addSubview(box)
        }
    }
}
