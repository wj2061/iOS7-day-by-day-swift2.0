//
//  SCModelViewController.swift
//  FlipCard
//
//  Created by wj on 15/10/25.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class SCModelViewController: UIViewController {
    weak var interactor:SCFlipAnimationInteractor?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        interactor?.presentingVC = self
    }

    @IBAction func handleDismissPressed(sender: UIButton) {
        dismissViewControllerAnimated(true , completion: nil)
    }
    
    
    override func proceedToNextViewController(){
        dismissViewControllerAnimated(true , completion: nil)

    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
