//
//  UIMethods.swift
//  MHSStats
//
//  Created by Ryan on 5/19/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit

public class UIMethods: UIView {
    
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
        return textHeight
    }
    
    func drawTextWithNoBox(x: CGFloat, y: CGFloat, width: CGFloat, toDraw: String, fontSize: CGFloat) -> CGFloat {
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
        message.drawInRect(CGRectMake(x, y, width, textHeight))
        return textHeight
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont, toGet: String) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.max)
        
        let boundingBox = toGet.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
    
}
