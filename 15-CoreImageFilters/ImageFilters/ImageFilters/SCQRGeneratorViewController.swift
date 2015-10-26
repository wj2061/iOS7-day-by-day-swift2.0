//
//  SCQRGeneratorViewController.swift
//  ImageFilters
//
//  Created by WJ on 15/10/26.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class SCQRGeneratorViewController: UIViewController {
    
    @IBOutlet weak var qrImageView: UIImageView!
    @IBOutlet weak var stringTextfield: UITextField!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var hImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleGenerateButtonPressed(sender: UIButton) {
        setUIElements(false)
        stringTextfield.resignFirstResponder()
        
        if  let stringToEncode = stringTextfield.text{
            let qrCode = createQR(stringToEncode)
            
            qrImageView.image = UIImage(CIImage: qrCode)
            hImageView.image = createNonInterpolatedUIImage(qrCode, scale: UIScreen.mainScreen().scale*2)
        }
        setUIElements(true)
    }

    // MARK: - Utility methods
    func createQR(string:String)->CIImage{
        let stringData = string.dataUsingEncoding(NSUTF8StringEncoding)
        let filter = CIFilter(name: "CIQRCodeGenerator")!
        
        filter.setValue(stringData, forKey: "inputMessage")
        filter.setValue("H", forKey: "inputCorrectionLevel")
        
        return filter.outputImage!
    }
    
    func setUIElements(enabled:Bool){
        stringTextfield.enabled = enabled
        generateButton.enabled = enabled
    }
    
    func createNonInterpolatedUIImage(ciimage:CIImage,scale:CGFloat)->UIImage{
        let cgImage = CIContext().createCGImage(ciimage, fromRect: ciimage.extent)
        
        UIGraphicsBeginImageContext(CGSize(width: ciimage.extent.width*scale, height: ciimage.extent
            .height*scale))
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetInterpolationQuality(context, CGInterpolationQuality.None)
        CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        let filppedImage = UIImage(CGImage: image.CGImage!, scale: image.scale, orientation: .DownMirrored)
        
        return filppedImage
    }


}
