//
//  ViewController.swift
//  ios-mqtt-base
//
//  Created by Anthony Perritano on 6/10/14.
//  Copyright (c) 2014 LTG. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet var topicTextField : UITextField
    @IBOutlet var messageTextField : UITextField
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendMessage(sender : AnyObject) {
        
        if messageTextField.text != nil {
            
            println("message \(messageTextField.text)")

            MQTTPipe.sharedInstance.sendMessage(messageTextField.text)
        }
        
    }

    @IBAction func subscribeTopic(sender : AnyObject) {
        
        if topicTextField.text {
            
            println("topic \(topicTextField.text)")
            
            MQTTPipe.sharedInstance.subscribeTopic(topicTextField.text)
        }
    }
}

