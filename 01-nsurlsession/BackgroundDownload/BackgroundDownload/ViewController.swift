//
//  ViewController.swift
//  BackgroundDownload
//
//  Created by WJ on 15/10/12.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,NSURLSessionDownloadDelegate{
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var progressIndicator: UIProgressView!

    @IBOutlet var startButtons: [UIBarButtonItem]!
    
    var resumableTask:NSURLSessionDownloadTask?
    
    var backgroundTask:NSURLSessionDownloadTask?

    lazy var backgroundSession:NSURLSession = setbackSession(self)()

    private func setbackSession() ->NSURLSession{
        let config = NSURLSessionConfiguration .backgroundSessionConfigurationWithIdentifier("com.shinobicontrols.BackgroundDownload.BackgroundSession")
          return NSURLSession(configuration: config, delegate: self, delegateQueue: nil)
    }

    private var inProcessSession:NSURLSession?
    
    private var cancellableTask:NSURLSessionDownloadTask?
    
    private var partialDownload:NSData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressIndicator.hidden = true
        progressIndicator.progress = 0
        
        backgroundSession.sessionDescription = "Background session"
    }


    @IBAction func startCancellable(sender: UIBarButtonItem) {
        if inProcessSession == nil{
            let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
            inProcessSession = NSURLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
            inProcessSession?.sessionDescription="in-process NSURLSession"
        }
        let url = "http://farm6.staticflickr.com/5505/9824098016_0e28a047c2_b_d.jpg"
        let request = NSURLRequest(URL: NSURL(string: url)!)
        
        cancellableTask = inProcessSession?.downloadTaskWithRequest(request)
        setDownloadButtonsAsEnabled(false )
        imageView.hidden = true
        cancellableTask?.resume()
    }
    
    @IBAction func cancelCancellable(sender: UIBarButtonItem) {
        if cancellableTask != nil{
            cancellableTask?.cancel()
            cancellableTask = nil
        }else if resumableTask != nil{
            resumableTask?.cancelByProducingResumeData({ (resumeData) -> Void in
                self.partialDownload = resumeData
                self.resumableTask = nil
            })
        }else if backgroundTask != nil{
            backgroundTask?.cancel()
            backgroundTask = nil
        }
    }
    
    @IBAction func startResumable(sender: UIBarButtonItem) {
        if resumableTask == nil{
            if inProcessSession == nil{
               let  sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
                inProcessSession = NSURLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
                inProcessSession?.sessionDescription = "in-process NSURLSession"
            }
            if partialDownload != nil{
                resumableTask = inProcessSession?.downloadTaskWithResumeData(partialDownload!)
            }else {
                let  url = "http://farm3.staticflickr.com/2846/9823925914_78cd653ac9_b_d.jpg"
                resumableTask = inProcessSession?.downloadTaskWithURL(NSURL(string: url)!)
            }
            setDownloadButtonsAsEnabled(false )
            imageView.hidden = true
            resumableTask?.resume()
        }
    }

    @IBAction func startBackground(sender: UIBarButtonItem) {
        
        let url = "http://farm3.staticflickr.com/2831/9823890176_82b4165653_b_d.jpg"
        backgroundTask = backgroundSession.downloadTaskWithURL(NSURL(string: url)!)
        setDownloadButtonsAsEnabled(false )
        imageView.hidden = true
        backgroundTask?.resume()
    }

    private func setDownloadButtonsAsEnabled(enabled:Bool){
        for  btn in startButtons{
            btn.enabled = enabled
        }
    }
    
    //MARK: - NSURLSessionDownloadDelegate
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL){
        let fileManger = NSFileManager.defaultManager()
        let URLs = fileManger.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)
        let documentsDirectory = URLs[0]
        let destinationPath = documentsDirectory.URLByAppendingPathComponent(location.lastPathComponent!)
        
        do{try fileManger.removeItemAtURL(destinationPath)
        }catch{}
        
        do{try fileManger.copyItemAtURL(location, toURL: destinationPath)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if  let image = UIImage(contentsOfFile: destinationPath.path!){
                    self.imageView.image = image
                    self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
                    self.imageView.hidden = false
                }
            })
        }
        catch{
            print ("Couldn't copy the downloaded file")
        }
        
        if downloadTask == cancellableTask{
            cancellableTask = nil
        }else if downloadTask == backgroundTask{
            resumableTask = nil
            partialDownload = nil
        }else if session == backgroundSession{
            backgroundTask = nil
        }
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let currentProgress = Double(totalBytesWritten)/Double( totalBytesExpectedToWrite )
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.progressIndicator.hidden=false
            self.progressIndicator.progress = Float( currentProgress )
        }
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.progressIndicator.hidden = true
            self.setDownloadButtonsAsEnabled(true )
        }
    }
    
    
}

