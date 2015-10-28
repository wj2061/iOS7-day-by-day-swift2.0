//
//  SCViewController.swift
//  CodeScanner
//
//  Created by WJ on 15/10/28.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import AVFoundation

class SCViewController: UIViewController ,AVCaptureMetadataOutputObjectsDelegate{
    var previewLayer:AVCaptureVideoPreviewLayer!
    let decodedMessage =  UILabel()
    let boundingBox = SCShapeView()
    var boxHideTimer:NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let session = AVCaptureSession()
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            session.addInput(input)
        }catch{
            print("error")
            return
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        print("\(output.availableMetadataObjectTypes)")
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer.bounds = view.bounds
        previewLayer.position = view.center
        view.layer.addSublayer(previewLayer)
        
        decodedMessage.frame = CGRect(x: 0, y: CGRectGetHeight(view.bounds)-75, width: CGRectGetWidth(view.bounds), height: 75)
        decodedMessage.numberOfLines = 0
        decodedMessage.backgroundColor = UIColor(white: 0.8, alpha: 0.9)
        decodedMessage.textColor = UIColor.darkGrayColor()
        decodedMessage.textAlignment = NSTextAlignment.Center
        view.addSubview(decodedMessage)
        
        boundingBox.frame = view.bounds
        boundingBox.backgroundColor = UIColor.clearColor()
        boundingBox.hidden = true
        view.addSubview(boundingBox)
        
        session.startRunning()
    }
    
    //MARK:-AVCaptureMetadataOutputObjectsDelegate
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        for metadata in metadataObjects{
            if metadata.type == AVMetadataObjectTypeQRCode{
                let transformed = previewLayer.transformedMetadataObjectForMetadataObject(metadata as! AVMetadataObject) as! AVMetadataMachineReadableCodeObject
                
                decodedMessage.text = transformed.stringValue
                
                boundingBox.hidden = false
                boundingBox.corners = transformed.corners.map{(point)->CGPoint in
                    let dict = point as! NSDictionary
                    let x = dict["X"]!.doubleValue
                    let y = dict["Y"]!.doubleValue
                    
                    return CGPoint(x: x, y: y)
                }
                startOverlayHideTimer()
            }
        }
    }

    
    func startOverlayHideTimer(){
        if boxHideTimer != nil{
            boxHideTimer!.invalidate()
        }
        boxHideTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("removeBoundingBox:"), userInfo: nil, repeats: false)
    }
    
    func removeBoundingBox(timer:NSTimer){
        print("hide")
        
        boundingBox.hidden = true
        decodedMessage.text = ""
    }
}
