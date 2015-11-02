//
//  SCMasterViewController.swift
//  PhotoSender
//
//  Created by WJ on 15/11/2.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import MultipeerConnectivity


class SCMasterViewController: UIViewController , MCSessionDelegate , MCBrowserViewControllerDelegate ,UIImagePickerControllerDelegate ,UINavigationControllerDelegate{

    @IBOutlet weak var peerNameTextField: UITextField!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var findPeersButton: UIButton!
    
    var peerID :MCPeerID?
    var session :MCSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func handleFindPeersButton() {
        peerNameTextField.resignFirstResponder()
        if peerNameTextField.text == nil || peerNameTextField.text == ""{
            let alert = UIAlertController(title: "Peer name", message: "You must specify a peer name to browse.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (_ ) -> Void in}))
            presentViewController(alert, animated: true, completion: nil)
        }else{
            peerID = MCPeerID(displayName: peerNameTextField.text!)
            session = MCSession(peer: peerID!)
            session?.delegate = self
            let browerVC = MCBrowserViewController(serviceType: "shinobi-stream", session: session!)
            browerVC.delegate = self
            presentViewController(browerVC, animated: true, completion: nil)
        }
    }
    

    @IBAction func handleTakePhotoButtonPressed() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil )
    }
    
    
    //MARK:  - MCSessionDelegate methods
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        
    }
    
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
        
    }
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
        
    }
    
    //MARK: - MCBrowserViewControllerDelegate methods

    func browserViewControllerDidFinish(browserViewController: MCBrowserViewController) {
        browserViewController.dismissViewControllerAnimated(true) { () -> Void in
            self.takePhotoButton.enabled = true
        }
        
    }
    
    func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController) {
        browserViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK:-  UIImagePickerControllerDelegate methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let photo = info[UIImagePickerControllerOriginalImage] as! UIImage
        let smallImage = rescaleImage(photo, size: CGSize(width: 800, height: 600))
        let jpeg = UIImageJPEGRepresentation(smallImage, 0.2)
        dismissViewControllerAnimated(true) { () -> Void in
            do{
                try             self.session?.sendData(jpeg!, toPeers: self.session!.connectedPeers, withMode: MCSessionSendDataMode.Reliable)
            }catch let error {
                print("error =  \(error )")
            }
        }
    }
    
    
    func rescaleImage(image:UIImage,size:CGSize)->UIImage{
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
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
