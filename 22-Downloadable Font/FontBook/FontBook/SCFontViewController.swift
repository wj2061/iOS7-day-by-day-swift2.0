//
//  SCFontViewController.swift
//  FontBook
//
//  Created by WJ on 15/11/1.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class SCFontViewController: UITableViewController {
    
    var fontList = [UIFontDescriptor](){
        didSet{
            if oldValue != fontList{
                tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let descriptor = fontList[indexPath.row]
        cell.textLabel?.text = descriptor.objectForKey(UIFontDescriptorNameAttribute) as? String
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail"{
            let VC = segue.destinationViewController as! SCDetailViewController
            let indexpath = tableView.indexPathForCell(sender as! UITableViewCell)!
            VC.fontDescriptor = fontList[indexpath.row]
        }
    }

}
