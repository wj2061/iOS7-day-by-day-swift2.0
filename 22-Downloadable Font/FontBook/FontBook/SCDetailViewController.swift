//
//  SCDetailViewController.swift
//  FontBook
//
//  Created by WJ on 15/11/1.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class SCDetailViewController: UIViewController {
    @IBOutlet weak var downloadProgressBar: UIProgressView!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var sampleTextLabel: UILabel!
    
    var fontDescriptor: UIFontDescriptor!{
        didSet{
            if oldValue != fontDescriptor{
                updateView()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }


    func updateView(){
        let fontName = fontDescriptor.objectForKey(UIFontDescriptorNameAttribute) as? String
        self.title = fontName
        let font = UIFont(name: fontName!, size: 26.0)
        if font != nil && font!.fontName == fontName{
            sampleTextLabel?.font = font
            downloadButton?.enabled = false
            detailDescriptionLabel?.text = "Font available"
        }else{
            sampleTextLabel?.font = UIFont.systemFontOfSize(26.0)
            downloadButton?.enabled = true
            detailDescriptionLabel?.text = "This font is not yet downloaded"
        }
    }
    
    @IBAction func handleDownloadPressed(sender: UIButton) {
        downloadProgressBar.hidden = false
        CTFontDescriptorMatchFontDescriptorsWithProgressHandler([fontDescriptor], nil) { (state, progressParameter) -> Bool in
            let progressValue = ( progressParameter as NSDictionary).objectForKey( kCTFontDescriptorMatchingPercentage)?.doubleValue ?? 0.0
            
            print(progressValue)
            if state == CTFontDescriptorMatchingState.DidFinish {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.downloadProgressBar.hidden = true
                    self.updateView()
                })
            }else{
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.downloadProgressBar.progress = Float( progressValue/100)
                })
            }
            return true
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
