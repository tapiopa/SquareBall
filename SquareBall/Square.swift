//
//  Square.swift
//  SquareBall
//
//  Created by Työ on 17.9.2017.
//  Copyright © 2017 Tapio. All rights reserved.
//

import Foundation
import UIKit

struct Square {
    var centerX: CGFloat = 0
    var centerY: CGFloat = 0
    var diameter: CGFloat = 100
    var color: CGColor = UIColor.blue.cgColor
    var rectX: CGFloat { return centerX - diameter/2 }
    var rectY: CGFloat { return centerY - diameter/2 }
    var width: CGFloat { return diameter }
    var height: CGFloat { return diameter }
    var lineWidth: CGFloat { return CGFloat(4.0) }
    var rect: CGRect { return CGRect(x: centerX, y: centerY, width: width, height: height) }
    
    func contains(point: CGPoint) -> Bool {
        if point.x < rectX || point.x > rectX + width { return false }
        if point.y < rectY || point.y > rectY - height { return false }
        return true
    }
    
    func asImage() -> UIImage {
        // 2. Get graphics context
        let contextSize: CGSize = CGSize(width: width, height: height)
        let opaque = true
        let scale: CGFloat = 0.0
        UIGraphicsBeginImageContextWithOptions(contextSize, opaque, scale)
        let context = UIGraphicsGetCurrentContext()
        //
        // 3. draw the pie chart
        context!.setFillColor(color)
        context?.addRect(rect)
        context!.closePath()
        context!.fillPath()
        
        // 4. draw the outline
        context!.setLineWidth(lineWidth)
        context!.setStrokeColor(UIColor.white.cgColor)
        context?.addRect(rect)
        context!.strokePath()
        
        // 5. return the image
        let result: UIImage  = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return result;
    }

    func squareBySize(imageSize: CGFloat, outlineWidth: CGFloat, squareColor: UIColor, height: CGFloat) -> UIImage
    {
        // 1. Constants for circle
        let centerPoint: CGPoint = CGPoint(x: imageSize/2, y: imageSize/2)
        let squareOrigin: CGPoint = CGPoint(x: centerPoint.x - height/2, y: centerPoint.y - height/2)
        let squareSize = CGSize(width: height, height: height)
        let squareRect = CGRect(origin: squareOrigin, size: squareSize)
        
        // 2. Get graphics context
        let contextSize: CGSize = CGSize(width:imageSize, height: imageSize)
        let opaque: Bool = true
        let scale: CGFloat = 0.0
        UIGraphicsBeginImageContextWithOptions(contextSize, opaque, scale)
        let  context: CGContext = UIGraphicsGetCurrentContext()!
        
        // 3. draw the square
        context.setFillColor(squareColor.cgColor)
        context.addRect(squareRect)
        context.closePath()
        context.fillPath()
        
        // 4. draw the outline
        context.setLineWidth(lineWidth)
        context.setStrokeColor(UIColor.white.cgColor)
        context.addRect(squareRect)
        context.strokePath()
        
        context.strokePath();
        
        // 5. return the image
        let result: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return result;
    }
    
    func loadImage() -> UIImage {
        var image: UIImage;
        let totalImages: Int = 100
        let imageSize: CGFloat = 100
        let outlineWidth: CGFloat = 2.0
        let color: UIColor = UIColor.blue
        var animationFrames: [UIImage] = [UIImage]()
        
        // generate pie chart images for the values of 0 to 100
        for i in 0...totalImages {
            //print("i: ", i, "totalImages: ", totalImages)
            image = squareBySize(imageSize: imageSize, outlineWidth: outlineWidth, squareColor: color, height: CGFloat(i))
            animationFrames.append(image)
        }
        
        // set the animation duration to be very short as the digital crown can dial very fast
        let animationDuration: Double = 0.0;
        return UIImage.animatedImage(with: animationFrames, duration: animationDuration)!
    }    
}
