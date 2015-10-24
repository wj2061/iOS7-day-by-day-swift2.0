//
//  SCIndividualStepViewController.swift
//  RouteMaster
//
//  Created by wj on 15/10/24.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import MapKit

class SCIndividualStepViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var instructionTextView: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    
    var routeStep:MKRouteStep?
    var stepIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        if let step = routeStep{
            mapView.addOverlay(step.polyline)
            mapView.setVisibleMapRect(step.polyline.boundingMapRect, animated: true)
            instructionTextView.text = step.instructions
            navigationItem.title = "Step \(stepIndex)"
            distanceLabel.text = "\(round(step.distance/10.0)/100) km"
        }
    }
    
    //MARK:- MKMapViewDelegate methods
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.redColor()
        renderer.lineWidth = 5.0
        return renderer
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
