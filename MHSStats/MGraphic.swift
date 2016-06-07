//
//  MGraphic.swift
//  MHSStats
//
//  Created by Ryan on 3/11/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit

public class MGraphic : UIView {
    
    var toAdd: UIImage?

    public init(screenWidth: Double, y: Double) {
        self.toAdd = UIImage(named: "m.png")
        let realWidth = FileStructure.mWidth
        let halfScreenWidth = Double(screenWidth / 2)
        let halfWidth = Double(realWidth) / 2.0
        super.init(frame: CGRect(x: (halfScreenWidth - halfWidth), y: y, width: (realWidth), height: (FileStructure.mHeight)))
        self.toAdd = resizeImage(toAdd!, newWidth: CGFloat(FileStructure.mWidth), newHeight: CGFloat(FileStructure.mHeight))
        self.backgroundColor = UIColor.clearColor()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    override public func drawRect(rect: CGRect) {
        toAdd?.drawInRect(CGRect(x: 0, y: 0, width: toAdd!.size.width, height: toAdd!.size.height))
    }

    func resizeImage(image: UIImage, newWidth: CGFloat, newHeight: CGFloat) -> UIImage {
        
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}