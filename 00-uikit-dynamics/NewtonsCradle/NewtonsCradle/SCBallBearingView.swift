//
//  SCBallBearingView.swift
//  NewtonsCradle
//
//  Created by WJ on 15/10/13.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class SCBallBearingView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor    = UIColor.lightGrayColor()
        layer.cornerRadius = min(CGRectGetHeight(frame), CGRectGetWidth(frame))/2.0
        layer.borderColor  = UIColor.grayColor().CGColor
        layer.borderWidth  = 2
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor    = UIColor.lightGrayColor()
        layer.cornerRadius = min(CGRectGetHeight(frame), CGRectGetWidth(frame))/2.0
        layer.borderColor  = UIColor.grayColor().CGColor
        layer.borderWidth  = 2
    }
    



}
