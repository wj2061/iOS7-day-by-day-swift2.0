//
//  SCViewController.swift
//  RouteMaster
//
//  Created by wj on 15/10/24.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import MapKit

class SCViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var routeButton: UIButton!
    @IBOutlet weak var routeDetailButton: UIButton!
    
    var routeOverlay : MKPolyline?
    var currentRoute:MKRoute?
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidden = true
        routeDetailButton.hidden = true
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined{
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    @IBAction func handleRoutePressed(sender: UIButton) {
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        
        routeButton.enabled = false
        routeDetailButton.enabled = false
        
        let directionsRequest = MKDirectionsRequest()
        directionsRequest.source = MKMapItem.mapItemForCurrentLocation()
        
        let  destinationCoords = CLLocationCoordinate2D(latitude: 39.542637, longitude: 116.232922)//set destination to beijing
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoords, addressDictionary: nil)
        directionsRequest.destination = MKMapItem(placemark: destinationPlacemark)
        
        let directions = MKDirections(request: directionsRequest)
        directions.calculateDirectionsWithCompletionHandler { (response, error) -> Void in
            self.activityIndicator.hidden = true
            self.routeButton.enabled = true
            
            if error != nil {
                print("\(error!)")
                return
            }
            self.routeDetailButton.hidden = false
            self.routeDetailButton.enabled = true
            if let route = response?.routes.first{
                self.currentRoute = route
                self.plotRouteOnMap(route)
            }
        }
    }
    
    //MARK:- Utility Method
    func plotRouteOnMap(route: MKRoute){
        if routeOverlay != nil{
            mapView.removeOverlay(routeOverlay!)
        }
        routeOverlay = route.polyline
        mapView.addOverlay(routeOverlay!)
    }
    
    //MARK:- MKMapViewDelegate methods
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.redColor()
        renderer.lineWidth = 5.0
        return renderer
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       if segue.identifier == "showRoute"{
          if let vc = segue.destinationViewController as? SCStepsTableViewController{
            vc.route = currentRoute
          }
       }
    }

}
