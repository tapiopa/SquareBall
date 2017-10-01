//
//  Ball.swift Copyright (c) Kari Laitinen.
//  MovingBallsWithFinger
//
//  Created by kari on 09/09/14. (Objective-C)
//  2015-04-30 Swift version by Pekka Liukko.
//  2016-11-11 Last modification.

import Foundation
import UIKit

class Ball: NSObject
{
   var this_ball_is_activated: Bool = true
   var ball_center_point_x: CGFloat = 0
   var ball_center_point_y: CGFloat = 0
   var ball_diameter: CGFloat = 100
   var ball_color: CGColor = UIColor.black.cgColor
   
   init(_ given_center_point_x: CGFloat,
        _ given_center_point_y: CGFloat,
        _ given_color: CGColor
      )
   {
      self.ball_center_point_x = given_center_point_x
      self.ball_center_point_y = given_center_point_y
      self.ball_color = given_color
      self.this_ball_is_activated = false
      super.init()
   }
   
   override init()
   {
      super.init()
   }
   
   func activate_ball()
   {
      this_ball_is_activated  =  true
   }
   
   func deactivate_ball()
   {
      this_ball_is_activated  =  false
   }
   
   func get_ball_center_point_x() -> CGFloat
   {
      return ball_center_point_x
   }
   
   func get_ball_center_point_y () -> CGFloat
   {
      return ball_center_point_y
   }
   
   func get_ball_diameter() -> CGFloat
   {
      return ball_diameter
   }
   
   func move_right() -> Void
   {
      ball_center_point_x  +=  3
   }
   
   func move_left() -> Void
   {
      ball_center_point_x  -=  3
   }
   
   func move_up() -> Void
   {
      ball_center_point_y  -=  3
   }
   
   func move_down() -> Void
   {
      ball_center_point_y  +=  3
   }
   
   func move_this_ball(  _ movement_in_direction_x: CGFloat,
                         _ movement_in_direction_y: CGFloat ) -> Void
   {
      ball_center_point_x  =  ball_center_point_x  +  movement_in_direction_x
      ball_center_point_y  =  ball_center_point_y  +  movement_in_direction_y
   
   }
   
   func move_to_position( _ new_center_point_x: CGFloat,
                          _ new_center_point_y: CGFloat ) -> Void
   {
      ball_center_point_x  =  new_center_point_x
      ball_center_point_y  =  new_center_point_y
      
   }
   
   func shrink() -> Void
   {
      //  The if-construct ensures that the ball does not become
      //  too small.
      if ( ball_diameter  > 10 )
      {
         ball_diameter  -=  6 ;
      }
   }
   
   func enlarge() ->Void
   {
      ball_diameter += 6
   }

   func set_diameter( _ new_diameter: CGFloat ) -> Void
   {
      if ( new_diameter  >  5 )
      {
         ball_diameter = new_diameter
      }
   }
   
   func set_color( _ new_color: CGColor ) -> Void
   {
      ball_color = new_color
   }
   
   func contains_point( _ given_point: CGPoint ) -> Bool
   {
      let ball_radius = ball_diameter / 2
      
      //  Here we use the Pythagorean theorem to calculate the distance
      //  from the given point to the center point of the ball.
      
      let distance_from_given_point_to_ball_center =
          sqrt(   pow( Double( ball_center_point_x -  given_point.x  ), 2.0 ) +
                  pow( Double( ball_center_point_y -  given_point.y  ), 2.0 )
      )
      
      return( distance_from_given_point_to_ball_center <= Double( ball_radius ) )
   }
   
   func draw( _ given_context: CGContext ) -> Void
   {
      given_context.saveGState()
   
      given_context.setStrokeColor( UIColor.black.cgColor )
      given_context.setFillColor(  ball_color )
   
      //  If this ball is activated, it will have a thick black edge
   
      if ( this_ball_is_activated == true )
      {
         given_context.setLineWidth( 4.0 )
      }
      else
      {
         given_context.setLineWidth( 2.0 )
      }
   
      given_context.beginPath()
      let rectangle_for_ball_bounds: CGRect =
         CGRect( x: ball_center_point_x - ball_diameter / 2 ,
                 y: ball_center_point_y - ball_diameter / 2,
                 width:  ball_diameter, height: ball_diameter )
      
      given_context.addEllipse( in: rectangle_for_ball_bounds )
   
      // The following call both fills and draws the path.
   
      given_context.drawPath( using: CGPathDrawingMode.fillStroke );
   
      given_context.restoreGState()
   }
}
