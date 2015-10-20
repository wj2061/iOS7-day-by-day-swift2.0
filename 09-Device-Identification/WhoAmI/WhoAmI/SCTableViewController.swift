//
//  SCTableViewController.swift
//  WhoAmI
//
//  Created by WJ on 15/10/20.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import AdSupport

class SCTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 2:
            return 1
        case 1:
            return 2
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "Vendor IDs"
        case 1:
            return "Advertising IDs"
        case 2:
            return "Networking"
        default:
            return nil
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        switch indexPath.section{
        case 0:
            cell.textLabel?.text = "identifierForVendor"
            cell.detailTextLabel?.text = UIDevice.currentDevice().identifierForVendor?.UUIDString
        case 1:
            if indexPath.row == 0{
                cell.textLabel?.text = "advertisingIdentifier"
                cell.detailTextLabel?.text = ASIdentifierManager.sharedManager().advertisingIdentifier.UUIDString
            }else {
                cell.textLabel?.text = "isAdvertisingEnabled"
                cell.detailTextLabel?.text = ASIdentifierManager.sharedManager().advertisingTrackingEnabled ? "YES" : "NO"
            }
        case 2:
            cell.textLabel?.text = "MAC Adddress"
            cell.detailTextLabel?.text = MACAddressForBSD("en0")
        default:
            break
        }
        return cell
    }
    
    func workaFunction(function:())->Bool{
        function
        return true
    }
    
    /*
    func getMacAddress()->String{
        var  mgmtInfoBase:[Int32] = [0,0,0,0,0,0]
        var  msgBuffer:UnsafeMutablePointer<CChar> = nil
        var  errorFlag = ""
        var  length:size_t = 0
        
        mgmtInfoBase[0] = CTL_NET
        mgmtInfoBase[1] = AF_ROUTE
        mgmtInfoBase[2] = 0
        mgmtInfoBase[3] = AF_LINK
        mgmtInfoBase[4] = NET_RT_IFLIST
        mgmtInfoBase[5] = Int32(if_nametoindex("en0"))
        
        if mgmtInfoBase[5]  == 0{
            errorFlag = "if_nametoindex failure"
        }else if sysctl(&mgmtInfoBase, 6, nil, &length, nil, 0) < 0{
            errorFlag = "sysctl mgmtInfoBase failure"
           
        }else if workaFunction(msgBuffer =  UnsafeMutablePointer<CChar>(malloc(length)) ) && msgBuffer == nil  {
            errorFlag = "buffer allocation failure"
        }else if sysctl(&mgmtInfoBase, 6, msgBuffer, &length, nil, 0) < 0{
            free(msgBuffer)
             errorFlag = "sysctl msgBuffer failure"
        }else{
            let interfaceMsgStruct = if_msghdr()
            interfaceMsgStruct. // give up
            
            
            
        }

        return errorFlag
    }
*/
    func MACAddressForBSD(bsd : String) -> String?
    {
        let MAC_ADDRESS_LENGTH = 6
        let separator = ":"
        
        var length : size_t = 0
        var buffer : [CChar]
        
        let BSDIndex = Int32(if_nametoindex(bsd))
        if BSDIndex == 0 {
            print("Error: could not find index for bsd name \(bsd)")
            return nil
        }
        let bsdData = bsd.dataUsingEncoding(NSUTF8StringEncoding)!
        
        var managementInfoBase = [CTL_NET, AF_ROUTE, 0, AF_LINK, NET_RT_IFLIST, BSDIndex]
        
        if sysctl(&managementInfoBase, 6, nil, &length, nil, 0) < 0 {
            print("Error: could not determine length of info data structure");
            return nil;
        }
        
        buffer = [CChar](count: length, repeatedValue: 0)
        
        if sysctl(&managementInfoBase, 6, &buffer, &length, nil, 0) < 0 {
            print("Error: could not read info data structure");
            return nil;
        }
        
        let infoData = NSData(bytes: buffer, length: length)
        var interfaceMsgStruct = if_msghdr()
        infoData.getBytes(&interfaceMsgStruct, length: sizeof(if_msghdr))
        let socketStructStart = sizeof(if_msghdr) + 1
        let socketStructData = infoData.subdataWithRange(NSMakeRange(socketStructStart, length - socketStructStart))
        let rangeOfToken = socketStructData.rangeOfData(bsdData, options: NSDataSearchOptions(rawValue: 0), range: NSMakeRange(0, socketStructData.length))
        let macAddressData = socketStructData.subdataWithRange(NSMakeRange(rangeOfToken.location + 3, MAC_ADDRESS_LENGTH))
        var macAddressDataBytes = [UInt8](count: MAC_ADDRESS_LENGTH, repeatedValue: 0)
        macAddressData.getBytes(&macAddressDataBytes, length: MAC_ADDRESS_LENGTH)
        let addressBytes = macAddressDataBytes.map({ String(format:"%02x", $0) })
        
        return addressBytes.joinWithSeparator(separator)
    }





}
