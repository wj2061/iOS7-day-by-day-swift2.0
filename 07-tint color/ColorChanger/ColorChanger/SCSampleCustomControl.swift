//
//  SCSampleCustomControl.swift
//  ColorChanger
//
//  Created by wj on 15/10/17.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class SCSampleCustomControl: UIView {
    let tintColorBlock = UIView()
    
    let greyLabel = UILabel()
    
    let tintColorLabel = UILabel()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = UIColor.clearColor()
        prepareSubviews()
    }


    private func prepareSubviews(){
        tintColorBlock.backgroundColor = tintColor
        addSubview(tintColorBlock)
        
        greyLabel.text = "Grey label"
        greyLabel.textColor = UIColor.grayColor()
        greyLabel.sizeToFit()
        addSubview(greyLabel)
        
        tintColorLabel.text = "Tint color label"
        tintColorLabel.textColor = tintColor
        tintColorLabel.sizeToFit()
        addSubview(tintColorLabel)
    }
    
    override func layoutSubviews() {
        tintColorBlock.frame = CGRectMake(0, 0, CGRectGetWidth(bounds)/3, CGRectGetHeight(bounds))
        
        var frame = greyLabel.frame
        frame.origin.x = CGRectGetWidth(bounds)/3 + 10
        frame.origin.y = 0
        greyLabel.frame = frame
        
        frame = tintColorLabel.frame
        frame.origin.x = CGRectGetWidth(bounds)/3 + 10
        frame.origin.y = CGRectGetHeight(bounds)/2
        tintColorLabel.frame = frame
    }
    
    override func tintColorDidChange() {
        tintColorLabel.textColor = tintColor
        tintColorBlock.backgroundColor = tintColor
    }

}
