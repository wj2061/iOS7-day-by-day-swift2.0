//
//  SCStepsTableViewController.swift
//  RouteMaster
//
//  Created by wj on 15/10/24.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import MapKit

class SCStepsTableViewController: UITableViewController {
    var route: MKRoute?
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return route?.steps.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let step = route!.steps[indexPath.row]
        cell.textLabel?.text = "\(indexPath.row))\(round(step.distance/10.0)/100)km"
        cell.detailTextLabel?.text = step.notice

        return cell
    }


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail"{
            if let vc = segue.destinationViewController as? SCIndividualStepViewController{
                let indexpath = tableView.indexPathForCell(sender! as! UITableViewCell)!
                vc.stepIndex = indexpath.row
                vc.routeStep = route!.steps[indexpath.row]
            }
        }
    }

}
