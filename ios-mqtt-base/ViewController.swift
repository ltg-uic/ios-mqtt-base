//
//  ViewController.swift
//  ios-mqtt-base
//
//  Created by Anthony Perritano on 6/10/14.
//  Copyright (c) 2014 LTG. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    

    /*
        The value in this property represents the heading that points toward the geographic North Pole. 
        The value in this property is always reported relative to the top of the
        device, regardless of the device’s physical or interface orientation. 
        The value 0 represents true North, 90 represents due East, 180 represents due South, and so on. 
        A negative value indicates that the heading could not be determined.
    */
    @IBOutlet var trueHeading : UILabel
    
    /*

        Magnetic north represents the point on the Earth’s surface from which the planet’s magnetic field emanates. 
        This location is not the same as the North Pole, which represents true north. Depending on the location of the device, 
        magnetic north may be good enough for many purposes, but the closer to the poles you get, the less useful this value becomes.
    */
    @IBOutlet var magneticHeading : UILabel
    @IBOutlet var mainView : MainView = nil
    
    var locationManager: CLLocationManager = CLLocationManager()
    var currentHeading: CLHeading = CLHeading();
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        self.locationManager.headingFilter = 1;
        self.locationManager.delegate = self;
        
        self.locationManager.startUpdatingHeading();
    }

    
    
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        
        if newHeading.headingAccuracy < 0 {
            return;
        }
        
        // Use the true heading if it is valid.
        var theHeading: CLLocationDirection = ((newHeading.trueHeading > 0) ?
            newHeading.trueHeading : newHeading.magneticHeading);
        
        
        
        self.currentHeading = newHeading;
        

        
        self.trueHeading.text = NSString(format:"%.1f", newHeading.trueHeading)
  
        
    }
    
    func locationManagerShouldDisplayHeadingCalibration(manager: CLLocationManager!) -> Bool {
        if(self.currentHeading == nil) {
            return true;
        } else {
            return false;
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

