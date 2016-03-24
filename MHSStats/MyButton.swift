//
//  MyButton.swift
//  MHSStats
//
//  Created by Ryan on 3/16/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit

public class MyButton: UIButton {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override public func drawRect(rect: CGRect) {
        let path = UIBezierPath()
        let width = Int(self.frame.width)
        let gap = FileStructure.dashedLineGap
        let remainder = CGFloat(width) / CGFloat((gap + FileStructure.lineWidth))
        let remainderInt = (width) / ((gap + FileStructure.lineWidth)) + 1
        var addedWidth = Int(((CGFloat(remainderInt) - remainder) * CGFloat(gap + FileStructure.lineWidth)))
        while(addedWidth < width) {
            path.moveToPoint(CGPointMake(CGFloat(addedWidth), CGFloat(0)))
            path.addLineToPoint(CGPointMake(CGFloat(addedWidth + FileStructure.lineWidth), CGFloat(0)))
            path.closePath()
            UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).set()
            path.stroke()
            addedWidth += gap + FileStructure.lineWidth
        }
    }
    
    func drawCenteredTextInRect(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, toDraw: String, fontSize: CGFloat) -> CGFloat {
        let message: NSMutableAttributedString = NSMutableAttributedString(string: toDraw)
        
        let fieldColor: UIColor = UIColor.blackColor()
        let fieldFont = UIFont(name: "Helvetica Neue", size: CGFloat(fontSize))
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.alignment = NSTextAlignment.Center
        
        let attributes: NSDictionary = [
            NSForegroundColorAttributeName: fieldColor,
            NSParagraphStyleAttributeName: paraStyle,
            NSFontAttributeName: fieldFont!
        ]
        let countString = (message.length)
        message.addAttributes(attributes as! [String : AnyObject], range: NSRange(location: 0, length: countString) )
        let textHeight = self.heightWithConstrainedWidth(self.frame.width, font: UIFont.boldSystemFontOfSize(25), toGet: toDraw)
        message.drawInRect(CGRectMake(x, height / 2 - textHeight / 2 + y, width, height))
        return height
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont, toGet: String) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.max)
        
        let boundingBox = toGet.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
    
}
