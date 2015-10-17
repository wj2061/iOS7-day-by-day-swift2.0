//
//  ViewController.swift
//  ColorChanger
//
//  Created by wj on 15/10/17.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.tintAdjustmentMode = UIViewTintAdjustmentMode.Normal
        dimTintSwitch.on = false
        
        var shinobiHead = UIImage(named: "shinobihead")!
        shinobiHead = shinobiHead.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        tintedImageView.image = shinobiHead
        tintedImageView.contentMode = UIViewContentMode.ScaleAspectFit
    }
    
    private func updateProgressViewTint(){
        progressView.progressTintColor = view.tintColor
    }
    

    @IBOutlet weak var dimTintSwitch: UISwitch!

    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var tintedImageView: UIImageView!
    

    @IBAction func changeColorHandler() {
        let hue = CGFloat( arc4random()%256 )/256.0
        let saturation = CGFloat( arc4random()%128 )/256.0 + 0.5
        let brightness = CGFloat( arc4random()%128 )/256.0 + 0.5
        let  color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
        view.tintColor = color
        updateProgressViewTint()
    }
    
    @IBAction func dimTintHandler() {
        if dimTintSwitch.on {
            view.tintAdjustmentMode = UIViewTintAdjustmentMode.Dimmed
        }else{
            view.tintAdjustmentMode = UIViewTintAdjustmentMode.Normal
        }
        updateProgressViewTint()
    }
    
}

