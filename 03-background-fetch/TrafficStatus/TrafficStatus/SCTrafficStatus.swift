//
//  File.swift
//  TrafficStatus
//
//  Created by WJ on 15/10/19.
//  Copyright © 2015年 wj. All rights reserved.
//

import Foundation
import UIKit

class SCTrafficStatus{
    var color:UIColor
    var date:NSDate
    var status:String
    
    init(){
       color = availableColors.randomElement()
    
       status = availableRoads.randomElement()
        
       date = NSDate()
    }
    
    
    
    
     let availableColors:[UIColor] = [UIColor.redColor(),
                                            UIColor.orangeColor(),
                                            UIColor.yellowColor(),
                                            UIColor.greenColor()]
    
     let availableRoads = ["HWY-1",
                                 "Route 66",
                                 "US-1",
                                 "Lincoln Highway",
                                 "Blue Ridge Parkway",
                                 "HWY-375",
                                 "Columbia River Highway",
                                 "HI-360",
                                 "US-212"]
    
}

private extension Array {
    func randomElement()->Element{
        let randomIndex = random()%count
        return self[randomIndex]
    }
}
 