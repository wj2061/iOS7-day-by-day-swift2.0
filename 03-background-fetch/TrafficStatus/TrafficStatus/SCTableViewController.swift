//
//  SCTableViewController.swift
//  TrafficStatus
//
//  Created by WJ on 15/10/19.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class SCTableViewController: UITableViewController {
    var trafficStatusUpdates = [SCTrafficStatus]()
    
    let dateFormatter = NSDateFormatter()
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let dfs  =  NSDateFormatter.dateFormatFromTemplate("MMM d, HH:mm:ss", options: 0, locale: NSLocale.currentLocale())
        dateFormatter.dateFormat = dfs!
        
        createNewStatusUpdatesWithMin(1, max: 4, handler: nil)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trafficStatusUpdates.count
    }
    
    //MARK: - Utility methods
    @IBAction func refreshStatus() {
        createNewStatusUpdatesWithMin(1, max: 3) { () -> Void in
            self.refreshControl?.endRefreshing()
        }
        
    }
    
    func  createNewStatusUpdatesWithMin(min:Int ,max:Int,handler:(()->Void)?)->Int{
        let  numberToCreate = random()%(max-min)+min
        var indexPathsToUpdate = [NSIndexPath]()
        
        for  i in 0..<numberToCreate{
            trafficStatusUpdates.insert(SCTrafficStatus(), atIndex: 0)
            indexPathsToUpdate.append(NSIndexPath(forRow: i, inSection: 0))
        }
        
        tableView.insertRowsAtIndexPaths(indexPathsToUpdate, withRowAnimation: UITableViewRowAnimation.Fade)
        
        if handler != nil{
            handler!()
        }
        return numberToCreate
    }
    
    func insertStatusObjectsForFetchWithCompletionHandler(handler:(UIBackgroundFetchResult)->())->Int{
        let  numberCreate = createNewStatusUpdatesWithMin(1, max: 3, handler: nil)
        print("Background fetch completed - \(numberCreate) new updates")
        
        let  result = numberCreate > 0 ? UIBackgroundFetchResult.NewData: UIBackgroundFetchResult.NoData
        handler(result)
        return numberCreate
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! SCTrafficStatusTableCell
       
        let status = trafficStatusUpdates[indexPath.row]
        
        cell.updateLabel.text = dateFormatter.stringFromDate(status.date)
        cell.colorBlock.backgroundColor = status.color
        cell.statusLabel.text = status.status
        
        return cell
    }

}
