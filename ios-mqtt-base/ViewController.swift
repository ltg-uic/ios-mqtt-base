//
//  ViewController.swift
//  ios-mqtt-base
//
//  Created by Anthony Perritano on 6/10/14.
//  Copyright (c) 2014 LTG. All rights reserved.
//

import UIKit
import Photos
import Parse

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet var topicTextField : UITextField!
    @IBOutlet var messageTextField : UITextField!
    @IBOutlet weak var posterImageView: UIImageView!

    var selectedImage: UIImage?
    var fileUploadBackgroundTaskId : UIBackgroundTaskIdentifier?

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

        selectedImage = image
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

 
//        // Create a thumbnail and add a corner radius for use in table views
//        UIImage *thumbnailImage = [anImage thumbnailImage:86.0f
//        transparentBorder:0.0f
//        cornerRadius:10.0f
//        interpolationQuality:kCGInterpolationDefault];
//
//        // Get an NSData representation of our images. We use JPEG for the larger image
//        // for better compression and PNG for the thumbnail to keep the corner radius transparency
//        NSData *imageData = UIImageJPEGRepresentation(resizedImage, 0.8f);
//        NSData *thumbnailImageData = UIImageJPEGRepresentation(thumbnailImage, 0.8f);
//
//        if (!imageData || !thumbnailImageData) {
//            return NO;
//        }

        var reducedImage = UIImageJPEGRepresentation(selectedImage, 5.0)
        var pfile = PFFile(data: reducedImage)
        var bgTask = UIBackgroundTaskIdentifier()

        var gameScore = PFObject(className: "Photo")
        gameScore.setObject(pfile, forKey: "image")
        gameScore.saveInBackgroundWithBlock {
            (success: Bool!, error: NSError!) -> Void in
            if (success != nil) {
                NSLog("Object created with id: \(gameScore.objectId)")
            } else {
                NSLog("%@", error)
            }
        }
        
        bgTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { () -> Void in
            UIApplication.sharedApplication().endBackgroundTask(bgTask)
        }

        gameScore.saveInBackgroundWithBlock { (success: Bool!, error: NSError!) -> Void in
            if (success != nil) {
                NSLog("Object created with id: \(gameScore.objectId)")
            } else {
                NSLog("%@", error)
            }
            UIApplication.sharedApplication().endBackgroundTask(bgTask)
        }


    

        
    }
    @IBAction func printConsole(sender: AnyObject) {
        
        var query = PFQuery(className: "Photo")
        
        var o = query.getFirstObject()
        
        NSLog("%@", o.objectId as NSString)
        
//        query.getObjectInBackgroundWithId(gameScore.objectId) {
//            (scoreAgain: PFObject!, error: NSError!) -> Void in
//            if (scoreAgain != nil) {
//                NSLog("%@", scoreAgain.objectForKey("objectId") as NSString)
//            } else {
//                NSLog("%@", error)
//            }
//        }
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

