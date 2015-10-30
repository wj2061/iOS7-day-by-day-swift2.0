//
//  SCNonEstimatingTableViewDelegate.swift
//  VariTable
//
//  Created by WJ on 15/10/30.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class SCNonEstimatingTableViewDelegate: NSObject,UITableViewDelegate {
    var heightBlock :( (Int)->CGFloat )!
    
    init(heightBlock:(Int)->CGFloat) {
       self.heightBlock = heightBlock
        super.init()
    }
    
    //MARK: - UITableViewDelegate methods
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        print("Height (row \(indexPath.row))")
        return heightBlock(indexPath.row)
    }
}
