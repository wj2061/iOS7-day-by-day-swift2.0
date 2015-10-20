//
//  ViewController.swift
//  FeedReader
//
//  Created by WJ on 15/10/19.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController,UIWebViewDelegate {
    
    
    @IBAction func addReadList(sender: UIBarButtonItem) {
        if  let url  = webView.request?.URL{
           if  let readlist = SSReadingList.defaultReadingList(){
            if SSReadingList.supportsURL(url){
                do {try readlist.addReadingListItemWithURL(url, title: "001", previewText: nil)
                         print("Successfully added to reading list")
                }
                catch {  print("There was a problem adding to a reading list")}
            }
        }
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        
        if let url = NSURL(string:"https://www.google.com.hk"){
            let request = NSURLRequest(URL: url)
            webView.loadRequest(request)
        }
    }
    @IBOutlet weak var webView: UIWebView!


    @IBOutlet weak var backWard: UIBarButtonItem!

    @IBOutlet weak var forWard: UIBarButtonItem!
    
    
    func webViewDidStartLoad(webView: UIWebView) {
        if  let url  = webView.request?.URL{
            title = url.absoluteString
        }else{
            title = "brower"
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        backWard.enabled = webView.canGoBack
        forWard.enabled = webView.canGoForward
    }

    @IBAction func goback(sender: UIBarButtonItem) {
        webView.goBack()
    }

    @IBAction func goforward(sender: UIBarButtonItem) {
        webView.goForward()
    }
}

