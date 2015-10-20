//
//  SCGreetingLanguage.swift
//  GreetingSpeaker
//
//  Created by WJ on 15/10/15.
//  Copyright © 2015年 wj. All rights reserved.
//

import Foundation
import AVFoundation

class SCGreetingLanguage{
    class func listOfGreetings()->[SCGreetingLanguage]{
        return [
            SCGreetingLanguage(bcp47:"zh-CN" , name: "Chinese", greeting: "Ni hao"),
            SCGreetingLanguage(bcp47:"en-US" , name: "English (American)" ,greeting:"Howdy!"),
            SCGreetingLanguage(bcp47:"en-AU" , name: "English (Australia)" ,greeting:"G'day!"),
            SCGreetingLanguage(bcp47:"en-GB" , name: "English (British)", greeting:"How do you do?"),
            SCGreetingLanguage(bcp47:"fr-FR" , name: "French", greeting: "Bonjour"),
            SCGreetingLanguage(bcp47:"de-DE" , name: "German", greeting: "Guten Tag"),
            SCGreetingLanguage(bcp47:"it-IT" , name: "Italian", greeting: "Buongiorno"),
            SCGreetingLanguage(bcp47:"ja-JP" , name: "Japanese", greeting: "Kon'nichiwa"),
            SCGreetingLanguage(bcp47:"pt-PT" , name: "Portugese", greeting: "Olá"),
            SCGreetingLanguage(bcp47:"ru-RU" , name: "Russian", greeting: "privet"),
            SCGreetingLanguage(bcp47:"zh-CN" , name: "Chinese", greeting: "Ni hao"),
            SCGreetingLanguage(bcp47:"th-TH" , name: "Thai", greeting:"Sawadee Khaa")
        ]
    }
    
    let name :String
    let bcp47 :String
    let greeting: String
    
    init(bcp47:String,name:String,greeting:String){
        self.name = name
        self.bcp47 = bcp47
        self.greeting = greeting
    }
    
    func greetingUtterance()->AVSpeechUtterance?{
        if  let voice = AVSpeechSynthesisVoice(language: bcp47) {
            let utterance = AVSpeechUtterance(string: greeting)
            
            utterance.voice = voice
            
            utterance.rate *= 0.7
            return utterance
        }
        return nil
    }
    
    
    
}