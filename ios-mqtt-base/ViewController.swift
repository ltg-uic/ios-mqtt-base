//
//  ViewController.swift
//  ios-mqtt-base
//
//  Created by Anthony Perritano on 6/10/14.
//  Copyright (c) 2014 LTG. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet var topicTextField : UITextField!
    @IBOutlet var messageTextField : UITextField!
    @IBOutlet weak var posterImageView: UIImageView!

    let tapRecognizer = UITapGestureRecognizer()

    let uploadQueue : NSOperationQueue!
    var url : NSURL!

    override func viewDidLoad() {
        super.viewDidLoad()

        //tap
        tapRecognizer.addTarget(self, action: "selectImageFromLibrary")
        posterImageView.addGestureRecognizer(tapRecognizer)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectImageFromLibrary() {
        var picker : UIImagePickerController = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.delegate = self
        picker.allowsEditing = false
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
    
        posterImageView.image = image
        
        let postURL = "http://aaa:8080/send"
        let manager = AFHTTPRequestOperationManager()
       // let jpegImage = UIImageJPEGRepresentation(image, 0.5)
        

//        manager.POST(postURL, parameters: nil,
//            constructingBodyWithBlock: { (formData: (AFMultipartFormData?)->Void?) in
//                formData.appendPartWithFileData(data: image, name: "image", fileName: "test.jpeg", mimeType: "image/jpeg")
//            },
//            success: { operation, response in
//                println("[success] operation: \(operation), response: \(response)")
//            },
//            failure: { operation, error in
//                println("[fail] operation: \(operation), error: \(error)")
//            }
//        )
        

        
        picker.dismissViewControllerAnimated(true , completion: nil)
    }
    
    @IBAction func sendImageToPoster(sender: UIButton) {


        println("HEY THERE")
    }

    @IBAction func sendMessage(sender : AnyObject) {
        
        if messageTextField.text != nil {
            
            println("message \(messageTextField.text)")

            MQTTPipe.sharedInstance.sendMessage(messageTextField.text)
        }
        
    }

    @IBAction func subscribeTopic(sender : AnyObject) {
        
        if (topicTextField.text != nil) {
            
            println("topic \(topicTextField.text)")
            
            MQTTPipe.sharedInstance.subscribeTopic(topicTextField.text)
        }
    }
}

