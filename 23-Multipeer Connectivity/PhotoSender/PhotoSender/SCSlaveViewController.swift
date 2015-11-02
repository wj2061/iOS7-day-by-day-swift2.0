//
//  SCSlaveViewController.swift
//  PhotoSender
//
//  Created by WJ on 15/11/2.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class SCSlaveViewController: UIViewController ,MCSessionDelegate{

    @IBOutlet weak var peerNameTextField: UITextField!
    @IBOutlet weak var startAdvertisingButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var peerId :MCPeerID?
    var session : MCSession?
    var  advertiserAssistant :MCAdvertiserAssistant?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func handleStartAdvertisingButtonPressed() {
        peerNameTextField.resignFirstResponder()
        if peerNameTextField.text == nil || peerNameTextField.text == ""{
            let alert = UIAlertController(title: "Peer name", message: "You must specify a peer name to browse.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (_ ) -> Void in}))
            presentViewController(alert, animated: true, completion: nil)
        }else{
            peerId = MCPeerID(displayName: peerNameTextField.text!)
            session = MCSession(peer: peerId!)
            session?.delegate = self
            advertiserAssistant = MCAdvertiserAssistant(serviceType: "shinobi-stream", discoveryInfo: nil, session: session!)
            startAdvertisingButton.enabled = false
            peerNameTextField.enabled = false
            advertiserAssistant!.start()
        }
    }
    
    //MARK:  - MCSessionDelegate methods
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        
    }
    
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        print("didReceiveData")
        let image = UIImage(data: data)
        imageView.image = image
    }
    
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
        
    }
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
        
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
