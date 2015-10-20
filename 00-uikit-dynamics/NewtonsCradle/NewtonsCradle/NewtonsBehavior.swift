//
//  NewtonsBehavior.swift
//  NewtonsCradle
//
//  Created by WJ on 15/10/13.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class NewtonsBehavior: UIDynamicBehavior {
    
    let gravity = UIGravityBehavior()
    
    let collision = UICollisionBehavior()
    
    let itemBehavior = UIDynamicItemBehavior()
    
    override init() {
        super.init()
        gravity.magnitude = 10
        self.addChildBehavior(gravity)
        
        self.addChildBehavior(collision)
        
        itemBehavior.elasticity = 1.0
        itemBehavior.allowsRotation = true
        itemBehavior.resistance = 2.0
        self.addChildBehavior(itemBehavior)
    }
    
    func addView(ballView:UIView){
        gravity.addItem(ballView)
        collision.addItem(ballView)
        itemBehavior.addItem(ballView)
    }
    
    func removeView(ballView:UIView){
        gravity.removeItem(ballView)
        collision.addItem(ballView)
        itemBehavior.addItem(ballView)
    }
    

}
