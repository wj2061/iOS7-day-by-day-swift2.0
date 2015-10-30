//
//  SCViewController.swift
//  VariTable
//
//  Created by WJ on 15/10/30.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class SCViewController: UITableViewController {
    @IBInspectable var enableEstimation:Bool = false
    
    var  delegate : UITableViewDelegate!
    var loadStartTime : NSDate?

    override func viewDidLoad() {
        super.viewDidLoad()
        if enableEstimation{
             delegate = SCEstimatingTableViewDelegate(heightBlock: { (row ) -> CGFloat in
                return self.heightForRowAtIndex(row)
                }, estimationBlock: { (_ ) -> CGFloat in  return 40})
        }else{
            delegate = SCNonEstimatingTableViewDelegate(heightBlock: { (row) -> CGFloat in
                return self.heightForRowAtIndex(row)
            })
        }
        tableView.delegate = delegate
        loadStartTime = NSDate()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if loadStartTime != nil{
            let finishLoadTime = NSDate()
            let loadDuration = finishLoadTime.timeIntervalSinceDate(loadStartTime!)
            print("Total Load Time: \(round(loadDuration*100)/100)")
        }
        loadStartTime = nil
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 200
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let height = heightForRowAtIndex(indexPath.row)

        cell.textLabel?.text = "Cell \(String(format: "%03d",indexPath.row)))"
        cell.detailTextLabel?.text = "Height \(round(height*100)/100)"
 
        return cell
    }
    
    //MARK : - Utility methods

    func heightForRowAtIndex(index:Int)->CGFloat{
        var result = 1.0
        for  i in 0..<Int(1e5){
            result = sqrt(Double(i))
        }
        result = Double((index%3 + 1) * 20)
        return CGFloat(result)
    }
    



}
