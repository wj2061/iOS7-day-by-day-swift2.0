//
//  ViewController.swift
//  ViewSnapper
//
//  Created by wj on 15/10/18.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var complexView : SCRotatingViews?

    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createComplexView()
    }
    
    /**
    These 2 methods demonstrate how a UIView snapshot can be used in an animation
    to simplify complex views
    */
    
    @IBAction func handleAnimate(sender: UIBarButtonItem) {
        if let com = complexView{
            animateViewAwayAndReset(com)
        }
    }
    
    @IBAction func handleSnapshot(sender: UIBarButtonItem) {
        let  snapshotView = complexView!.snapshotViewAfterScreenUpdates(false )
        containerView.addSubview(snapshotView)
        complexView!.removeFromSuperview()
        animateViewAwayAndReset(snapshotView)
        
    }
    
    /**
    These 2 methods compare the difference between allowing screen updates and
    not
    */
    
    @IBAction func handlePreUpdateSnapshot(sender: UIBarButtonItem) {
        complexView!.recolorSubviews(UIColor.redColor().colorWithAlphaComponent(0.3))
        let  snapshotView = complexView!.snapshotViewAfterScreenUpdates(false )
        containerView.addSubview(snapshotView)
        complexView!.removeFromSuperview()
        animateViewAwayAndReset(snapshotView)
    }
    
    @IBAction func handlePostUpdateSnapshot(sender: UIBarButtonItem) {
        complexView!.recolorSubviews(UIColor.redColor().colorWithAlphaComponent(0.3))
        let  snapshotView = complexView!.snapshotViewAfterScreenUpdates(true  )
        containerView.addSubview(snapshotView)
        complexView!.removeFromSuperview()
        animateViewAwayAndReset(snapshotView)
    }
    /**
    This method demonstrate how to add an image effect to a UIView snapshot
    */
    
    @IBAction func handleImageSnapshot(sender: UIBarButtonItem) {
        UIGraphicsBeginImageContextWithOptions(complexView!.bounds.size, false, 0.0)
        
        complexView?.drawViewHierarchyInRect(complexView!.bounds, afterScreenUpdates: false)
        
        let complexViewImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let iv = UIImageView(image: applyBlurToImage(complexViewImage))
        iv.center = complexView!.center
        containerView.addSubview(iv)
        complexView!.removeFromSuperview()
        
        self.performSelector(Selector("animateViewAwayAndReset:"), withObject: iv, afterDelay: 1)   
    }
    
    
    //MARK:-  - Utility methods
    
    func createComplexView(){
        complexView = SCRotatingViews(frame:view.bounds)
        containerView.addSubview(complexView!)
    }
    
    func animateViewAwayAndReset(view:UIView){
        UIView.animateWithDuration(2, animations: { () -> Void in
            view.bounds = CGRectZero
            }) { (_) -> Void in
                view.removeFromSuperview()
                self.performSelector(Selector("createComplexView"), withObject: nil, afterDelay: 1)
        }
    }
    
    func applyBlurToImage(image :UIImage)->UIImage{
        let  context = CIContext(options: nil)
        let  CI_image = CIImage(image: image)
        let  filter = CIFilter(name: "CIGaussianBlur")
        filter!.setValue(CI_image, forKey: kCIInputImageKey)
        filter!.setValue(5, forKey: kCIInputRadiusKey)
        
        let result = filter!.valueForKey(kCIOutputImageKey) as! CIImage
        let cgImage = context.createCGImage(result, fromRect: result.extent)
        return  UIImage(CGImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
    }
}

