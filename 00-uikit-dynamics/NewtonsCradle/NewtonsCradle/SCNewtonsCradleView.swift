//
//  SCNewtonsCradleView.swift
//  NewtonsCradle
//
//  Created by WJ on 15/10/13.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class SCNewtonsCradleView: UIView {
    var animator :UIDynamicAnimator!
    
    var ballBearings : [UIView]!
    
    var userDragBehavior : UIPushBehavior?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        creatBallBearings()
        applyDynamicBehaviors()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        creatBallBearings()
        applyDynamicBehaviors()

    }
    
    func creatBallBearings(){
        var bbAray = [UIView]()
        let numberBalls = 5
        let ballSize = CGRectGetWidth(frame)/(3.0*CGFloat(numberBalls - 1))
        
        for i in 0..<numberBalls{
            let bb = SCBallBearingView(frame: CGRect(x: 0, y: 0, width: ballSize-1, height: ballSize-1))
            let x = CGRectGetWidth(bounds)/3.0 + CGFloat( i ) * ballSize
            let y = CGRectGetHeight(bounds)/2.0
            bb.center = CGPoint(x: x, y: y)
            
            let gesture = UIPanGestureRecognizer(target: self, action: Selector("handleBallBearingPan:"))
            bb.addGestureRecognizer(gesture)
            
            bbAray.append(bb)
            self.addSubview(bb)
        }
       ballBearings = bbAray
    }

   // MARK: - UIGestureRecognizer target method
    func handleBallBearingPan(gestrue:UIPanGestureRecognizer){
        switch gestrue.state {
        case UIGestureRecognizerState.Began:
            if userDragBehavior != nil{
                animator.removeBehavior(userDragBehavior!)
            }
            userDragBehavior = UIPushBehavior(items: [gestrue.view!], mode: UIPushBehaviorMode.Continuous)
            animator.addBehavior(userDragBehavior!)
            
            userDragBehavior?.pushDirection = CGVector(dx: gestrue.translationInView(self).x, dy: 0)
        case .Ended:
            animator.removeBehavior(userDragBehavior!)
            userDragBehavior = nil
        default:
            break
        }
    }
    
    func applyDynamicBehaviors(){
        let behavior = NewtonsBehavior()
        for ballBelling in ballBearings{
            let attachmentBehavior = createAttachmentBehaviorForBallBearing(ballBelling)
            behavior.addChildBehavior(attachmentBehavior)
            behavior.addView(ballBelling)
        }
//        
//        behavior.addChildBehavior(createGravityBehaviorForObjects(ballBearings))
//        behavior.addChildBehavior(createCollisionBehaviorForObjects(ballBearings))
//        
//        let itemBehavior = UIDynamicItemBehavior(items: ballBearings)
//        itemBehavior.elasticity = 1.0
//        itemBehavior.allowsRotation = false
//        itemBehavior.resistance = 2.0
//        behavior.addChildBehavior(itemBehavior)
        
        animator = UIDynamicAnimator(referenceView: self)
        animator.addBehavior(behavior)
    }
    
    func createAttachmentBehaviorForBallBearing(ballBearing:UIView) ->UIAttachmentBehavior{
        var anchor = ballBearing.center
        anchor.y  -= CGRectGetHeight(bounds)/4.0
        
        let blueView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        blueView.backgroundColor = UIColor.blueColor()
        blueView.center = anchor
        addSubview(blueView)
        
        let lineView = UIView (frame: CGRect(x: ballBearing.bounds.size.width/2, y: -anchor.y, width: 2, height: CGRectGetHeight(bounds)/4.0))
        lineView.backgroundColor = UIColor.redColor()
        ballBearing.addSubview(lineView)
        
        let linebehavior = UIAttachmentBehavior(item: lineView, offsetFromCenter: UIOffset(horizontal: 0, vertical:  CGRectGetHeight(lineView.bounds)/2), attachedToAnchor: anchor)
        
        
        let behavior = UIAttachmentBehavior(item: ballBearing, attachedToAnchor: anchor)
        behavior.addChildBehavior(linebehavior)
        return behavior
    }
    
    func createGravityBehaviorForObjects(objects:[UIView])->UIDynamicBehavior{
        let gravity = UIGravityBehavior(items: objects)
        gravity.magnitude = 10
        return gravity
    }
    
    func createCollisionBehaviorForObjects(objects:[UIView]) ->UIDynamicBehavior{
        return UICollisionBehavior(items: objects)
    }
    
    
}
