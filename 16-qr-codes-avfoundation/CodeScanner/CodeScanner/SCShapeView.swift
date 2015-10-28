//
//  SCShapeView.swift
//  CodeScanner
//
//  Created by WJ on 15/10/28.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class SCShapeView: UIView {
    var corners=[CGPoint](){
        didSet{
            if oldValue != corners{
                outline.path = createPath(corners)?.CGPath
            }
        }
    }

    private let  outline = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        outline.strokeColor = UIColor.blueColor().colorWithAlphaComponent(0.8).CGColor
        outline.lineWidth = 2.0
        outline.fillColor = UIColor.clearColor().CGColor
        layer.addSublayer(outline)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder )
        outline.strokeColor = UIColor.blueColor().colorWithAlphaComponent(0.8).CGColor
        outline.lineWidth = 2.0
        outline.fillColor = UIColor.clearColor().CGColor
        layer.addSublayer(outline)
    }
    
    func createPath(points:[CGPoint])->UIBezierPath?{
        if points.count < 2 {
            return nil
        }
        let path = UIBezierPath()
        path.moveToPoint(points[0])
        
        for i in 1..<points.count{
            path.addLineToPoint(points[i])
        }
        
        path.closePath()
//        path.addLineToPoint(points[0])
        return path
    }
}
