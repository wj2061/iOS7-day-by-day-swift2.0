//
//  SCFontFamilyViewController.swift
//  FontBook
//
//  Created by WJ on 15/11/1.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class SCFontFamilyViewController: UITableViewController {
    var fontFamilies = [String:[UIFontDescriptor]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        requestDownloadableFontList()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontFamilies.count
    }

    //MARK: -  Font-loading utility methods
    func requestDownloadableFontList(){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)){()->Void in
            let descriptorOptions = [String( kCTFontDownloadableAttribute):true]
            let descriptor = CTFontDescriptorCreateWithAttributes(descriptorOptions)
            let fontDescriptors = CTFontDescriptorCreateMatchingFontDescriptors(descriptor, nil)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.fontListDownloadComplete( fontDescriptors! )
            })
        }
    }
    
    func fontListDownloadComplete(fontList:NSArray){
//        var fontFamilies = [String:[UIFontDescriptor]]()
        for des in fontList{
           let   descriptor = des as! UIFontDescriptor
           let  fontFamilyName = descriptor.objectForKey(UIFontDescriptorFamilyAttribute) as! String
              if var fontDescriptors = fontFamilies[fontFamilyName] {
                 fontDescriptors.append(descriptor)
                 fontFamilies[fontFamilyName] = fontDescriptors
              }else{
                 let fontDescriptors = [descriptor]
                fontFamilies[fontFamilyName] = fontDescriptors
              }
        }
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let fontFamilyName = Array( fontFamilies.keys)[indexPath.row]
        cell.textLabel?.text = fontFamilyName
        cell.detailTextLabel?.text = "\(fontFamilies[fontFamilyName]!.count)"
        return cell
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showFont"{
            if let cell = sender as? UITableViewCell{
                let VC = segue.destinationViewController as! SCFontViewController
//                let index = tableView.indexPathForCell(cell)!
                VC.fontList = fontFamilies[(cell.textLabel!.text)!]!
                VC.title = cell.textLabel!.text
            }
        }
    }
}
