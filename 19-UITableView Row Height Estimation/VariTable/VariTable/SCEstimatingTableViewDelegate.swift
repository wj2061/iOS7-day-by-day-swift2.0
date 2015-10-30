//
//  SCEstimatingTableViewDelegate.swift
//  VariTable
//
//  Created by WJ on 15/10/30.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class SCEstimatingTableViewDelegate: SCNonEstimatingTableViewDelegate {
    var estimationBlock: ((Int)->CGFloat)!
    init(heightBlock: (Int) -> CGFloat,estimationBlock:(Int) -> CGFloat) {
        self.estimationBlock = estimationBlock
        super.init(heightBlock: heightBlock)
    }
    
   // MARK: - UITableViewDelegate methods
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        print("Estimating height (row \(indexPath.row))")
        return estimationBlock(indexPath.row)
    }
}
