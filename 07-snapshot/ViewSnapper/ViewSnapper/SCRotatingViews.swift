//
//  SCRotatingViews.swift
//  ViewSnapper
//
//  Created by wj on 15/10/18.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class SCRotatingViews: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        generateRotations()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func generateRotations(){
        for angle in 0..<20{
            let  newView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 250))
            newView.center = CGPoint(x: CGRectGetMidX( bounds), y: CGRectGetMidY(bounds))
            newView.layer.borderColor = UIColor.grayColor().CGColor
            newView.layer.borderWidth = 1
            newView.backgroundColor = UIColor(white: 0.8, alpha: 0.4)
            newView.transform = CGAffineTransformMakeRotation(CGFloat(angle)*CGFloat(M_PI)/20.0)
            newView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth,UIViewAutoresizing.FlexibleHeight]
            
            addSubview(newView)
        }
    }


    func recolorSubviews(newColor:UIColor)
    {
        for view in subviews{
            view.backgroundColor = newColor
        }
    }
}
