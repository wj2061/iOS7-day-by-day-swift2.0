//
//  ViewController.swift
//  MuiltiResolution
//
//  Created by WJ on 15/10/19.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var yPosition:CGFloat = 100
        
        for image  in images {
            let iv =  UIImageView(image: image)
            iv.center = CGPointMake(CGRectGetWidth(view.bounds)/2, yPosition)
            yPosition += 100
            view.addSubview(iv)
        }
        createButtonImages()
    }
    
    func createButtonImages(){
        let  btnImage = UIImage(named: "ButtonSlice")
        
        var iv = UIImageView(image: btnImage)
        iv.bounds = CGRectMake(0, 0, 150, CGRectGetHeight(iv.bounds))
        iv.center = CGPointMake(CGRectGetWidth(view.bounds)/2, 300)
        view.addSubview(iv)
        
        iv = UIImageView(image: btnImage)
        iv.bounds = CGRectMake(0, 0, 300, CGRectGetHeight(iv.bounds))
        iv.center = CGPointMake(CGRectGetWidth(view.bounds)/2, 350)
        view.addSubview(iv)
    }




    var  images:[UIImage]{
        return [UIImage(named: "USA")!,UIImage(named: "Australia")!]
    }
}

