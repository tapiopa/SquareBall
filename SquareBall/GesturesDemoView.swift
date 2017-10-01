//
//  GesturesDemoView.swift
//  GesturesDemo
//
//  Created by Pekka Liukko 2015-04-29
//  Copyright (c) Kari Laitinen. All rights reserved.

//  2015-05-21  Small modifications were necessary to run this with Xcode 6.3.2
//  2015-10-17  Modifications for Xcode 7, Swift 2
//  2016-11-11  Last modification.

import UIKit

class GesturesDemoView : UIView
{
   var text_lines_to_screen = [ "With this application, you can",
                                "explore what gesture events",
                                "take place when you play",
                                "with the touch screen",
                                " " ]
    var balls: [Ball?] = []
    let colors: [UIColor] = [UIColor.red, UIColor.green, UIColor.yellow, UIColor.cyan,
        UIColor.magenta, UIColor.blue, UIColor.brown, UIColor.gray, UIColor.orange]
    
    var numcolors = 0
    
   @IBAction func tap_detected(recognizer:UITapGestureRecognizer)
   {
      text_lines_to_screen.append("Tap")
      let tapped_point = recognizer.location(in: self)
    
    balls.append(Ball(tapped_point.x, tapped_point.y, colors[numcolors % 9].cgColor))
    numcolors += 1
      setNeedsDisplay() // "repaint" the view
   }
   
   @IBAction func swipe_detected(recognizer:UISwipeGestureRecognizer)
   {
      
      text_lines_to_screen.append("Swipe")
      
      setNeedsDisplay() // "repaint" the view
   }
   
   @IBAction func long_press_detected(recognizer:UILongPressGestureRecognizer)
   {
      
      text_lines_to_screen.append("Long Press")
      
      setNeedsDisplay() // "repaint" the view
   }
   
   @IBAction func pan_detected(recognizer:UIPanGestureRecognizer)
   {
      
      text_lines_to_screen.append("Pan")
      
      setNeedsDisplay() // "repaint" the view
   }
   
   @IBAction func rotation_detected(recognizer:UIRotationGestureRecognizer)
   {
      
      text_lines_to_screen.append("Rotation")
      
      setNeedsDisplay() // "repaint" the view
   }
   
   @IBAction func pinch_detected(recognizer:UIPinchGestureRecognizer)
   {
      
      text_lines_to_screen.append("Pinch")
      
      setNeedsDisplay() // "repaint" the view
   }
   
   @IBAction func screen_edge_pan_detected(recognizer:UIScreenEdgePanGestureRecognizer)
   {
      
      text_lines_to_screen.append("Screen Edge Pan")
      
      setNeedsDisplay() // "repaint" the view
   }
   
   override func draw(_ rect: CGRect)
   {
      // set the text color to black
      let fieldColor: UIColor = UIColor.black
      
      // set the font to Palatino-Roman 14
      let font = UIFont(name: "Palatino-Roman", size:14.0)
      
      // set the line spacing to 6
      let paraStyle = NSMutableParagraphStyle()
      paraStyle.lineSpacing = 6.0
      
      // set the Obliqueness to 0.1
      let skew = 0.0
      
      let attributes: NSDictionary = [
         NSAttributedStringKey.foregroundColor: fieldColor,
         NSAttributedStringKey.paragraphStyle: paraStyle,
         NSAttributedStringKey.obliqueness: skew,
         NSAttributedStringKey.font: font!
      ]
      
      
      // We'll delete the oldest lines from the array if necessary.
      while ( text_lines_to_screen.count > 10 )
      {
         text_lines_to_screen.remove( at: 0 )
      }
   
      
      for line_index in 0 ..< text_lines_to_screen.count
      {
         ( text_lines_to_screen[line_index] as NSString).draw(
            in: CGRect( x: 20.0, y: CGFloat(40 + 20 * line_index),
                        width: 300.0, height: 48.0),
            withAttributes: attributes as? [NSAttributedStringKey : AnyObject])
      }
    
    for ball in balls {
            ball?.draw(UIGraphicsGetCurrentContext()!)
        }
    }
}
