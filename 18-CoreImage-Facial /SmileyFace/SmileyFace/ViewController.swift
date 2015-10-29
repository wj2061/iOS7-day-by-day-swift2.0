//
//  ViewController.swift
//  SmileyFace
//
//  Created by WJ on 15/10/29.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController ,AVCaptureMetadataOutputObjectsDelegate{
    //outlet
    @IBOutlet weak var retakeButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    //var
    let session = AVCaptureSession()
    let stillImageOutput = AVCaptureStillImageOutput()
    var previewLayer:AVCaptureVideoPreviewLayer! = nil
    let ciContext = CIContext()
    var faceDetector:CIDetector! = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        session.sessionPreset = AVCaptureSessionPreset640x480
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        do{
            let input = try AVCaptureDeviceInput(device: device)
            session.addInput(input)
        }catch{
            print("error")
            return
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.metadataObjectTypes = [AVMetadataObjectTypeFace]
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        
        session.addOutput(stillImageOutput)
        stillImageOutput.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer.bounds = view.bounds
        previewLayer.position = view.center
        view.layer.insertSublayer(previewLayer, atIndex: 0)
        
        imageView.hidden = true
        retakeButton.hidden = true
        statusLabel.hidden = true
        activityView.hidden = true
        
        session.startRunning()
        
        faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: ciContext, options: nil)
    }


    @IBAction func handleStart() {
        previewLayer.hidden = false
        imageView.hidden = true
        statusLabel.hidden = true
        activityView.hidden = true
        retakeButton.hidden = true
        session.startRunning()
    }
    
    //MARK:- - AVCaptureMetadataOutputObjectsDelegate methods
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        for metadata in metadataObjects{
            if metadata.type   ==  AVMetadataObjectTypeFace{
                let stillConnection = stillImageOutput.connectionWithMediaType(AVMediaTypeVideo)
                stillImageOutput.captureStillImageAsynchronouslyFromConnection(stillConnection) {
                    (imageDataSampleBuffer, error ) -> Void in
                    if error != nil{
                        print("There was a problem ")
                        return
                    }
                     print("NO problem!!!")
                    self.imageView.hidden = false
                    self.view.insertSubview(self.imageView, atIndex: 0)

                        self.activityView.hidden = false
                        self.activityView.startAnimating()
                        self.statusLabel.text = "Processing"
                        self.statusLabel.hidden = false
 
                    self.previewLayer.hidden = true
                    self.retakeButton.hidden = false

                    let jpegData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
                    let smileyImage = UIImage(data: jpegData)

                    self.imageView.image = smileyImage
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                        self.session.stopRunning()
                    })
                    
                    let image =  CIImage(data: jpegData)
                    self.imageContainsSmiles(image!, callback: { (happyface) -> Void in
                        self.statusLabel.text = happyface ? "Happy Face Found!" : "Not a good photo..."
                        self.activityView.hidden = true
                        self.retakeButton.hidden = false
                    })
                }
            }
        }
   
    }
    
    func imageContainsSmiles(image:CIImage,callback:(Bool)->Void){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { () -> Void in
            let features = self.faceDetector.featuresInImage(image, options: [CIDetectorEyeBlink:true,CIDetectorSmile:true,CIDetectorImageOrientation:true])
            print("\(features.count) features")
            var happyPicture = features.count > 0 ? true   : false
            
            for feture in features{
                if  let ft = feture as? CIFaceFeature{
                    if !ft.hasSmile {
                        happyPicture = false
                    }
                    if ft.leftEyeClosed || ft.rightEyeClosed{
                        happyPicture = false
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                callback(happyPicture)
            })
        }
    }


}

