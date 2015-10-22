//
//  ViewController.swift
//  RainbowRotate
//
//  Created by WJ on 15/10/22.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rotatingHead: UIImageView!
    
    @IBOutlet weak var rainbowSwatch: UIView!
    @IBOutlet weak var toolbar: UIToolbar!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        rainbowSwatch.backgroundColor = UIColor.redColor()
    }
    

    //MARK: - Toolbar button handlers
    @IBAction func handlerotateCM(sender: UIBarButtonItem) {
        enableToolbarItems(false )
        let  animation = {()->Void in
            for i in 0...2 {
                UIView.addKeyframeWithRelativeStartTime(Double(i)/3.0, relativeDuration: 1.0/3.0){()->Void in
                    self.rotatingHead.transform = CGAffineTransformMakeRotation(CGFloat(2+2*i)*CGFloat(M_PI)/3.0)
                }
            }
        }
        
        UIView.animateKeyframesWithDuration(2.0, delay: 0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: animation) { (_ ) -> Void in
            self.enableToolbarItems(true )
        }
        
        
    }

    @IBAction func handlerotateCCM(sender: UIBarButtonItem) {
        enableToolbarItems(false )
        let  animation = {()->Void in
            for i in 0...2 {
                UIView.addKeyframeWithRelativeStartTime(Double(i)/3.0, relativeDuration: 1.0/3.0){()->Void in
                    self.rotatingHead.transform = CGAffineTransformMakeRotation(CGFloat(4-2*i)*CGFloat(M_PI)/3.0)
                }
            }
        }
        
        UIView.animateKeyframesWithDuration(2.0, delay: 0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: animation) { (_ ) -> Void in
            self.enableToolbarItems(true )
        }
        
    }

    @IBAction func handleRainbow(sender: UIBarButtonItem) {
        enableToolbarItems(false)
        
        let animation = {() -> Void in
            let  rainbowColors = [UIColor.orangeColor(),
                UIColor.yellowColor(),
                UIColor.greenColor(),
                UIColor.blueColor(),
                UIColor.purpleColor(),
                UIColor.redColor()]
            
            let colorCount = rainbowColors.count
            
            for i in 0..<colorCount{
                UIView.addKeyframeWithRelativeStartTime(Double(i)/Double(colorCount), relativeDuration: 1.0/Double(colorCount)) { () -> Void in self.rainbowSwatch.backgroundColor = rainbowColors[i]}
            }
        }
        
        UIView.animateKeyframesWithDuration(4.0, delay: 0, options: [UIViewKeyframeAnimationOptions.CalculationModeLinear], animations: animation) { (_ ) -> Void in
            self.enableToolbarItems(true )
        }

        
        
    }
    
    //MARK: - Utility methods
    
    private func  enableToolbarItems(enabled:Bool){
        for item in toolbar.items!{
            item.enabled = enabled
        }
    }
}

