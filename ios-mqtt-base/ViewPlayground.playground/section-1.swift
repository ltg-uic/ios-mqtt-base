// Playground - noun: a place where people can play


import UIKit

class TestView: UIView {
    
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
        
        line.lineWidth = 1;
        line.stroke()
        
        colorFill.set()
        ovalPath.fill()
        colorBorder.set()
        ovalPath.lineWidth = 2
        ovalPath.stroke()
        
    }

}


var view = TestView(frame:CGRect(x:0,y:0,width:1024,height:768))
view

