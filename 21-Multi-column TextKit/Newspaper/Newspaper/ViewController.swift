//
//  ViewController.swift
//  Newspaper
//
//  Created by WJ on 15/10/31.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    var textStorage:NSTextStorage!
    let layoutManager = NSLayoutManager()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentURL = NSBundle.mainBundle().URLForResource("content", withExtension: "txt")
        do{
//            textStorage = try NSTextStorage(URL: contentURL!, options: [NSObject : AnyObject](), documentAttributes: nil)
             textStorage = try NSTextStorage(URL: contentURL!, options: [String : AnyObject](), documentAttributes: nil)
        }catch{
            print("there is an error")
            return
        }
        
        textStorage.addLayoutManager(layoutManager)
        layoutTextContainers()
    }
    
    func layoutTextContainers(){
        var lastRenderedGlyph = 0
        var currentXOffset:CGFloat = 0.0
        
        while lastRenderedGlyph < layoutManager.numberOfGlyphs{
            let textViewFrame = CGRect(x: currentXOffset, y: 10, width: CGRectGetWidth(view.bounds)/2, height: CGRectGetHeight(view.bounds)-20)
            let columnSize = CGSize(width: CGRectGetWidth(textViewFrame)-20, height: CGRectGetHeight(textViewFrame)-10)
            
            let textContainer = NSTextContainer(size: columnSize)
            layoutManager.addTextContainer(textContainer)
            
            let textView = UITextView(frame: textViewFrame, textContainer: textContainer)
            textView.scrollEnabled = false
            scrollView.addSubview(textView)
            
            currentXOffset += CGRectGetWidth(textViewFrame)
            lastRenderedGlyph = NSMaxRange(layoutManager.glyphRangeForTextContainer(textContainer))
            print(lastRenderedGlyph)
        }
        let contentSize = CGSize(width: currentXOffset, height: CGRectGetHeight(scrollView.bounds))
        scrollView.contentSize = contentSize
    }
}

