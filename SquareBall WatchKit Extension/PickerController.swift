//
//  pickerController.swift
//  SquareBall WatchKit Extension
//
//  Created by Työ on 30.9.2017.
//  Copyright © 2017 Tapio. All rights reserved.
//
import WatchKit
import Foundation

class PickerController: WKInterfaceController {
    
    @IBOutlet var picker: WKInterfacePicker!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        /// PIECHART
        // 1. generate the animated images
        //let pieChart = Pie().loadImage()
        // 2. load the picker with images
        //var pickerItems = [WKPickerItem]()
        /*for picture in pieChart.images! {
            let item = WKPickerItem()
            item.contentImage = WKImage(image: picture)
            pickerItems.append(item)
        }*/
        //picker.setItems(pickerItems)
        //picker.focus()
        //picker.setItems(createItems(from: Pie().loadImage()))
        
        
        ///RECTANGLE
        //picker.setItems(createItems(from: Rectangle().loadImage()))
        
        ///SQUARE
        //picker.setItems(createItems(from: Square().loadImage()))
        
        ///TRIANGLE
        picker.setItems(createItems(from: Triangle().loadImage()))
        
        // 3. set the initial index to 30 %
        picker.setSelectedItemIndex(30)

        picker.focus()
    }
    
    func createItems(from image: UIImage) -> [WKPickerItem]{
        var pickerItems = [WKPickerItem]()
        for picture in image.images! {
            let item = WKPickerItem()
            item.contentImage = WKImage(image: picture)
            pickerItems.append(item)
        }
        return pickerItems
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
}
