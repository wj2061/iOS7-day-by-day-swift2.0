//
//  ViewController.swift
//  GreetingSpeaker
//
//  Created by WJ on 15/10/15.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()
       languagePicker?.dataSource = self
       languagePicker?.delegate = self

        
       greetingLabel.text = availableLanguages.first?.greeting
        
        print("\(AVSpeechSynthesisVoice.speechVoices())")
    }

    let availableLanguages = SCGreetingLanguage.listOfGreetings()
    
    let speechSynthesizer = AVSpeechSynthesizer()

    @IBOutlet weak var languagePicker: UIPickerView!

    @IBOutlet weak var greetingLabel: UILabel!
    
    @IBAction func greetingButtonPressed() {
        let index = languagePicker.selectedRowInComponent(0)
        if let  gl = availableLanguages[index].greetingUtterance(){
            speechSynthesizer.speakUtterance(gl)
        }
    }
    
   //MARK:-  UIPickerViewDelegate methods
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return availableLanguages[row].name
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        greetingLabel.text = availableLanguages[row].greeting
        print("Language selected:\(availableLanguages[row].bcp47)")
    }
    
    //MARK :- UIPickerViewDatasource methods
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return availableLanguages.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
}

