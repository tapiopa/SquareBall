//
//  Triangle.swift
//  SquareBall
//
//  Created by Työ on 17.9.2017.
//  Copyright © 2017 Tapio. All rights reserved.
//

import Foundation
import UIKit

struct Triangle {
    var centerX: CGFloat = 50
    var centerY: CGFloat = 50
    var width: CGFloat = 100 //triangle width, triangle height = sqrt(3)/2, CGRect height = width
    var fillColor: CGColor = UIColor.yellow.cgColor
    var strokeColor: CGColor = UIColor.white.cgColor
    let maxLineWidth = CGFloat(4.0)
    
    var height: CGFloat { return width * (sqrt(3.0)/2.0) } //triangle height (NOT bounding rectangle height)
    var center: CGPoint { return CGPoint(x: centerX, y: centerY) }
    var boundingOrigin: CGPoint { return CGPoint(x: CGFloat(0.0), y: CGFloat(0.0)) }
    var triangleOrigin: CGPoint { return CGPoint(x: maxLineWidth, y: maxLineWidth) }
    var boundingSize: CGSize { return CGSize(width: width, height: width) }
    var triangleSize: CGSize { return CGSize(width: width - maxLineWidth*2, height: width - maxLineWidth*2) }
    var boundingRect: CGRect { return CGRect(origin: boundingOrigin, size: boundingSize) }
    var triangleRect: CGRect { return CGRect(origin: triangleOrigin, size: triangleSize) }
    
    var base1:CGPoint { return CGPoint(x: triangleOrigin.x, y: triangleSize.height) }
    var base2:CGPoint { return CGPoint(x: triangleOrigin.x + triangleSize.width, y: triangleSize.height) }
    var zenith:CGPoint { return CGPoint(x: center.x, y: triangleOrigin.y) }
    
    var lineWidth: CGFloat { return CGFloat(2.0) }
    
    func contains(point: CGPoint) -> Bool {
        if point.x < base1.x || point.x > base2.x { return false } //out of bounding rectangle
        if point.y < base1.y || point.y > zenith.y { return false } //out of bounding rectangle
        
        let rise = CGFloat(height / width/2)
        var relX = point.x - base1.x
        let relY = point.y - zenith.y
        
        //left half of bounding rectangle
        if point.x < center.x {
            if relY >= rise * relX { return false }
        }
        
        //right half of bounding rectangle
        relX = point.x - center.x
        if relY >= -rise * relX { return false }
        
        return true
    }
    
    func asImage() -> UIImage {
        let opaque = true
        let scale: CGFloat = 0.0
        UIGraphicsBeginImageContextWithOptions(boundingSize, opaque, scale)
        let context = UIGraphicsGetCurrentContext()
        //
        print("image triangle base1:", base1, ",", "base2:", base2, "zenith:", zenith)

        // 3. draw the triangle
        context!.setFillColor(fillColor)
        context!.setLineWidth(lineWidth)
        context!.setStrokeColor(strokeColor)
        context!.beginPath()
        context!.move(to: base1)
        context!.addLine(to: zenith)
        context!.addLine(to: base2)
        context!.addLine(to: base1)
        context!.drawPath(using: CGPathDrawingMode.fillStroke)
        context!.fillPath()
        
        // 5. return the image
        let result: UIImage  = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return result;
    }
    
    func triangleByAngle(imageSize: CGFloat, outlineWidth: CGFloat, triangleColor: UIColor, shift: CGFloat) -> UIImage
    {
        // 1. Points for triangle
        let degToRad = CGFloat(Double.pi / 180) //One degree in rad
        let angleZ = (90 - shift) * degToRad
        let angle1 = (210 - shift) * degToRad
        let angle2 = (330 - shift) * degToRad
        let r = imageSize / 2
        let centerPoint = imageSize / 2
        //let dX = cos(angle)
        //let dY = sin(angle)
        let baseA = CGPoint(x: centerPoint + cos(angle1) * r, y: centerPoint - sin(angle1) * r)
        let baseB = CGPoint(x: centerPoint + cos(angle2) * r, y: centerPoint - sin(angle2) * r)
        let zenith0 = CGPoint(x: centerPoint + cos(angleZ) * r, y: centerPoint - sin(angleZ) * r)
        
        //print("create shift:", shift, ", angle:", angle, ", dX:", dX, ", dY:", dY )
        //print("angles 1: (", cos(angle1), ",", sin(angle1), "), 2: (", cos(angle2), ",", sin(angle2), "), z: (", cos(angleZ), ",", sin(angleZ), ")")
        //print("points baseA:", baseA, ",", "baseB:", baseB, "zenith0:", zenith0)
        
        // 2. Get graphics context
        let contextSize: CGSize = CGSize(width:imageSize, height: imageSize)
        let opaque: Bool = true
        let scale: CGFloat = 0.0
        UIGraphicsBeginImageContextWithOptions(contextSize, opaque, scale)
        let  context: CGContext = UIGraphicsGetCurrentContext()!
        
        //3. draw triangle
        context.setFillColor(fillColor)
        context.setLineWidth(lineWidth)
        context.setStrokeColor(strokeColor)
        context.beginPath()
        context.move(to: baseA)
        context.addLine(to: zenith0)
        context.addLine(to: baseB)
        context.addLine(to: baseA)
        context.drawPath(using: CGPathDrawingMode.fillStroke)
        context.fillPath()
        
        context.strokePath();
        
        // 5. return the image
        let result: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return result;
    }
    
    func loadImage() -> UIImage {
        var image: UIImage
        let totalImages: Int = 120
        let imageSize: CGFloat = 100
        let outlineWidth: CGFloat = 5.0
        let color: UIColor = UIColor.yellow
        var animationFrames: [UIImage] = [UIImage]()
        
        // generate triangle images for the values of 0 to 120
        for i in 0...totalImages {
            //print("triangle i: ", i, "totalImages: ", totalImages)
            image = triangleByAngle(imageSize: imageSize, outlineWidth: outlineWidth, triangleColor: color, shift: CGFloat(i))
            animationFrames.append(image)
        }
        
        // set the animation duration to be very short as the digital crown can dial very fast
        let animationDuration: Double = 0.0;
        return UIImage.animatedImage(with: animationFrames, duration: animationDuration)!
    }
}
