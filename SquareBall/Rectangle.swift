//
//  Rectangle.swift
//  SquareBall
//
//  Created by Työ on 17.9.2017.
//  Copyright © 2017 Tapio. All rights reserved.
//

import UIKit

struct Rectangle {
    var centerX: CGFloat = 0
    var centerY: CGFloat = 0
    var diameter: CGFloat = 100
    var fillColor: CGColor = UIColor.blue.cgColor
    var strokeColor: CGColor = UIColor.white.cgColor
    let maxLineWidth: CGFloat = CGFloat(4.0)
    
    var rectX: CGFloat { return centerX - width/2 }
    var rectY: CGFloat { return centerY - height/2 }
    var boundingOrigin: CGPoint { return CGPoint(x: CGFloat(0.0), y: CGFloat(0.0)) }
    var rectangleOrigin: CGPoint { return CGPoint(x: maxLineWidth, y: maxLineWidth) }
    var height: CGFloat { return diameter/2 }
    var width: CGFloat { return diameter }
    var boundingSize: CGSize { return CGSize(width: width, height: height) }
    var rectangleSize: CGSize { return CGSize(width: width - maxLineWidth*2, height: height - maxLineWidth*2) }
    var lineWidth: CGFloat { return CGFloat(2.0) }
    var boundingRect: CGRect { return CGRect(origin: boundingOrigin, size: boundingSize) }
    var rectangleRect: CGRect { return CGRect(origin: rectangleOrigin, size: rectangleSize) }
    
    func contains(point: CGPoint) -> Bool {
        if point.x < rectX || point.x > rectX + width { return false }
        if point.y < rectY || point.y > rectY + height { return false }
        return true
    }
    
    func asImage() -> UIImage {
        let opaque = true
        let scale: CGFloat = 0.0
        UIGraphicsBeginImageContextWithOptions(boundingSize, opaque, scale)
        let context = UIGraphicsGetCurrentContext()
        
        // 3. draw the pie chart
        context!.setFillColor(fillColor)
        context?.addRect(rectangleRect)
        context!.fillPath()

        // 4. draw the outline
        context!.setLineWidth(lineWidth)
        context!.setStrokeColor(strokeColor)
        context?.addRect(boundingRect)
        context!.strokePath();
        
        // 5. return the image
        let result: UIImage  = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return result;
    }
    
    func rectangleByHeight(imageSize: CGFloat, outlineWidth: CGFloat, rectColor: UIColor, height: CGFloat) -> UIImage {
        // 1. Constants for circle
        let centerPoint: CGPoint = CGPoint(x: imageSize/2, y: imageSize/2)
        let rectOrigin = CGPoint(x: CGFloat(0.0), y: centerPoint.y - height/2)
        let rectSize = CGSize(width: rectangleSize.width, height: height)
        let rect = CGRect(origin: rectOrigin, size: rectSize)
        // 2. Get graphics context
        let contextSize: CGSize = CGSize(width:imageSize, height: imageSize)
        let opaque: Bool = true
        let scale: CGFloat = 0.0
        UIGraphicsBeginImageContextWithOptions(contextSize, opaque, scale)
        let  context: CGContext = UIGraphicsGetCurrentContext()!
        
        // 3. draw the rect
        context.setLineWidth(lineWidth)
        context.setStrokeColor(strokeColor)
        context.setFillColor(rectColor.cgColor)
        context.addRect(rect)
        context.strokePath()
        
        // 5. return the image
        let result: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return result
    }
    
    func loadImage() -> UIImage {
        var image: UIImage;
        let totalImages: Int = 100
        let imageSize: CGFloat = 100
        let outlineWidth: CGFloat = 2.0
        let color: UIColor = UIColor.cyan
        var animationFrames: [UIImage] = [UIImage]()
        
        // generate rectangle images for the values of 0 to 100
        for i in 0...totalImages {
            //print("i: ", i, "totalImages: ", totalImages)
            image = rectangleByHeight(imageSize: imageSize, outlineWidth: outlineWidth, rectColor: color, height: CGFloat(Double(i)))
            animationFrames.append(image)
        }
        
        // set the animation duration to be very short as the digital crown can dial very fast
        let animationDuration: Double = 0.0;
        return UIImage.animatedImage(with: animationFrames, duration: animationDuration)!
    }    
}
