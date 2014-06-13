//
//  MainView.swift
//  ios-mqtt-base
//
//  Created by Anthony Perritano on 6/13/14.
//  Copyright (c) 2014 LTG. All rights reserved.
//

import Foundation
import UIKit

class MainView: UIView {
    
//    var trueHeading
//    var magneticHeading
//    var degrees
    
    override func drawRect(rect: CGRect) {
        
        let viewHeightCenter: CGFloat = self.frame.height / 2.0
        let viewWidthCenter: CGFloat = self.frame.width / 2.0
        let radius: CGFloat = 30
        
        
        let colorBorder = UIColor(red: 0.343, green: 1, blue: 1, alpha: 1);
        let colorFill = UIColor(red: 0.114, green: 0.114, blue: 1, alpha: 1.0)
        
        var ovalPath = UIBezierPath(ovalInRect:CGRectMake(viewWidthCenter - (radius/2), viewHeightCenter - (radius/2), radius, radius))
        
        
        var line = UIBezierPath()
        
        line.moveToPoint(CGPointMake(viewWidthCenter, viewHeightCenter))
        
        line.addLineToPoint(CGPointMake(viewWidthCenter, 0));
        
        line.lineCapStyle = kCGLineCapRound;
        
        colorFill.set()
        line.stroke()
        
        line.lineWidth = 2;
        line.stroke()
        
        colorFill.set()
        ovalPath.fill()
        colorBorder.set()
        ovalPath.lineWidth = 2
        ovalPath.stroke()
        
    }
    
    
}