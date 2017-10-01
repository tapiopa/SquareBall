//
//  InterfaceController.swift
//  SquareBall WatchKit Extension
//
//  Created by Työ on 13.9.2017.
//  Copyright © 2017 Tapio. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet var image: WKInterfaceImage!
    
    @IBAction func tapCtrl(_ sender: Any) {
        print("tapped")
        ExtensionDelegate.imageIndex += 1
        image.setImage(ExtensionDelegate.shapes[ExtensionDelegate.imageIndex % 4])
    }
    
 
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        //image.setImage(pickImage(action: .format, index: 0))
        image.setImage(ExtensionDelegate.shapes[ExtensionDelegate.imageIndex])
        
 
    }

    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
