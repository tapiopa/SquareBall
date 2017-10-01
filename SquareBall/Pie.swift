//
//  Pie.swift
//  SquareBall
//
//  Created by Tapio Paloniemi on 23.9.2017.
//  Copyright © 2017 Tapio Paloniemi. All rights reserved.
//
// Adapted from https://www.codeproject.com/Articles/1038384/Create-a-Simple-Apple-Watch-App-Using-CoreGraphics

import Foundation
import UIKit

struct Pie {

    var centerX: CGFloat = 50
    var centerY: CGFloat = 50
    var diameter: CGFloat = 100
    //var fillColor: CGColor = UIColor.red.cgColor
    var strokeColor: CGColor = UIColor.darkGray.cgColor
    let maxLineWidth: CGFloat = CGFloat(4.0)
    var center: CGPoint { return CGPoint(x: centerX + maxLineWidth, y: centerY + maxLineWidth) }
    var radius: CGFloat { return diameter / 2 - maxLineWidth}
    //var width: CGFloat { return diameter + maxLineWidth * 2 }
    //var height: CGFloat { return width /*diameter + maxLineWidth * 2*/ }
    
    // Bounding rectangles
    //var boundingOrigin: CGPoint { return CGPoint(x: CGFloat(0.0), y: CGFloat(0.0)) }
    //var outlineOrigin: CGPoint { return CGPoint(x: CGFloat(maxLineWidth), y: CGFloat(maxLineWidth)) }
    //var ballOrigin: CGPoint { return CGPoint(x: CGFloat(maxLineWidth*2), y: CGFloat(maxLineWidth*2)) }
    //var contextSize: CGSize { return CGSize(width: width, height: height/**1.3*/) }
    //var surroundingCircleSize: CGSize { return CGSize(width: width - maxLineWidth*2, height: height - maxLineWidth*2) }
    //var ballSize: CGSize { return CGSize(width: width - maxLineWidth*2, height: height - maxLineWidth*2)}
    //var boundingRect: CGRect { return CGRect(origin: boundingOrigin, size: contextSize) }
    //var outlineRect: CGRect { return CGRect(origin: outlineOrigin, size: surroundingCircleSize) }
    //var ballRect: CGRect { return CGRect(origin: outlineOrigin, size: ballSize) }
    
    
    func pieChartImageBySize(imageSize: CGFloat, outlineWidth: CGFloat, pieColor: UIColor, startRatio: CGFloat, endRatio: CGFloat) -> UIImage
    {
        // 1. Constants for circle
        let fullCircle: CGFloat = CGFloat(2.0 * Double.pi)//
        let initialAngle: CGFloat = CGFloat(3.0 * Double.pi/2)//
        //let startRatio: CGFloat = CGFloat(0.0)
        //let endRatio: CGFloat = CGFloat(1.0) //CGFloat(2.0 * Double.pi)
        let startAngle: CGFloat = startRatio * fullCircle + initialAngle
        let endAngle: CGFloat = endRatio * fullCircle + initialAngle
        let centerPoint: CGPoint = CGPoint(x: imageSize/2, y: imageSize/2)
        //let origin: CGPoint = CGPoint(x: CGFloat(0.0), y: CGFloat(0.0))
        let radius: CGFloat = (imageSize/2) - outlineWidth
        
        // 2. Get graphics context
        let contextSize: CGSize = CGSize(width:imageSize, height: imageSize)
        let opaque: Bool = true
        let scale: CGFloat = 0.0
        UIGraphicsBeginImageContextWithOptions(contextSize, opaque, scale)
        let  context: CGContext = UIGraphicsGetCurrentContext()!
        
        // 3. draw the pie chart
        context.setFillColor(pieColor.cgColor);
        context.addArc(center: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        context.addLine(to: centerPoint)
        context.closePath()
        context.fillPath()
    
        // 4. draw the outline
        context.setLineWidth(outlineWidth)
        context.setStrokeColor(strokeColor)
        context.addArc(center: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        context.strokePath();
        
        // 5. return the image
        let result: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return result;
    }
    
    func loadImage() -> UIImage {
        var image: UIImage;
        let start: CGFloat = 0.0
        var end: CGFloat
        let totalImages: Int = 100
        let imageSize: CGFloat = 100
        let outlineWidth: CGFloat = 5.0
        let color: UIColor = UIColor.cyan
        var animationFrames: [UIImage] = [UIImage]()
    
        // generate pie chart images for the values of 0 to 100
        for i in 0...totalImages {
            end = CGFloat(Double(i)/Double(totalImages))
            //print("i: ", i, "end: ", end, "totalImages: ", totalImages)
            image = pieChartImageBySize(imageSize: imageSize, outlineWidth: outlineWidth, pieColor: color, startRatio: start, endRatio: end)
            animationFrames.append(image)
        }
        
        // set the animation duration to be very short as the digital crown can dial very fast
        let animationDuration: Double = 0.0;
        return UIImage.animatedImage(with: animationFrames, duration: animationDuration)!
     }    
}
