//
//  ViewController.swift
//  HotOrCold
//
//  Created by WJ on 15/10/27.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import CoreBluetooth
import CoreLocation

class ViewController: UIViewController ,CLLocationManagerDelegate,CBPeripheralManagerDelegate{
    //outlet
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var signalStrengthLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet var goButtons: [UIButton]!
    
    //var
    let beaconUUID = NSUUID(UUIDString: "3B2DCB64-A300-4F62-8A11-F6E7A06E4BC0")!
    let clLocationManager = CLLocationManager()
    var rangedRegion:CLBeaconRegion?
    var cbPeripheralManager : CBPeripheralManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //init property
        clLocationManager.delegate = self
        rangedRegion = CLBeaconRegion(proximityUUID: beaconUUID, identifier: "com.shinobicontrols.HotOrCold")
        cbPeripheralManager = CBPeripheralManager(delegate: self, queue: dispatch_get_main_queue())
        
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined{
            clLocationManager.requestWhenInUseAuthorization()
        }
        
        //updateUI
        signalStrengthLabel.text = ""
        statusLabel.text = ""
        setProcessActive(false)
    }
    
    func setProcessActive(active:Bool){
        for bt in goButtons{
            bt.hidden = active
        }
        stopButton.hidden = !active
    }

    @IBAction func handleHidingButtonPressed(sender: UIButton) {
        if cbPeripheralManager!.state != CBPeripheralManagerState.PoweredOn  {
            print("Bluetooth must be enabled in order to act as an iBeacon")
        return
        }
        
        let toBroadcast = rangedRegion!.peripheralDataWithMeasuredPower(-60)
        var dict = [String:AnyObject]()
        for (key,value ) in toBroadcast{
            dict[key as! String] = value
        }

        cbPeripheralManager!.startAdvertising(dict)
        statusLabel.text = "hiding..."
        setProcessActive(true)
    }

    @IBAction func handleSeekingButtonPressed(sender: AnyObject) {
        setProcessActive(true)
        clLocationManager.startRangingBeaconsInRegion(rangedRegion!)
    }
    @IBAction func handleStopButtonPressed(sender: UIButton) {
        cbPeripheralManager?.stopAdvertising()
        clLocationManager.stopRangingBeaconsInRegion(rangedRegion!)
        statusLabel.text = ""
        setProcessActive(false)
        view.backgroundColor = UIColor.whiteColor()
        statusLabel.textColor = UIColor.blackColor()
        signalStrengthLabel.text = ""
    }
    
    //MARK: - CLLocationManagerDelegate methods
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        if region != rangedRegion {return }
        let beacon = beacons[0]
        statusLabel.textColor =  UIColor.whiteColor()
        signalStrengthLabel.textColor = UIColor.whiteColor()
        signalStrengthLabel.text = "\(beacon.rssi)dB"
        
        switch beacon.proximity{
        case .Unknown:
            view.backgroundColor = UIColor.blueColor()
            statusLabel.text = "Freezing!"
        case .Far:
            view.backgroundColor = UIColor.blueColor()
            statusLabel.text = "Cold"
        case .Immediate:
            view.backgroundColor = UIColor.purpleColor()
            statusLabel.text = "Warmer"
        case .Near:
            view.backgroundColor = UIColor.redColor()
            statusLabel.text = "Hot"
        }
    }
    
    //MARK : -  CBPeripheralManager delegate methods
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        // We don't really care...
    }
 
}

