//
//  CartItems.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/18/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SwiftyJSON

class CartItems: NSObject {
    var link:String?
    var cat_link:String?
    var cat_name:String?
    var name:String?
    var quantity:Int?
    var discount:Int?
    var price:Int?
    var total_price:Int?
    var name_print:String?
    var color:String?
    var weight:String?
    var image:String?
    
    
    override init() {
    }
    
    init(parametersJson: [String: JSON])
    {
        if let link = parametersJson["link"]?.stringValue
        {
            self.link = link
        }
        
        if let cat_link = parametersJson["cat_link"]?.stringValue
        {
            self.cat_link = cat_link
        }
        
        if let cat_name = parametersJson["cat_name"]?.stringValue
        {
            self.cat_name = cat_name
        }
        
        if let name = parametersJson["name"]?.stringValue
        {
            self.name = name
        }
        
        if let quantity = parametersJson["quantity"]?.intValue
        {
            self.quantity = quantity
        }
        
        if let discount = parametersJson["discount"]?.intValue
        {
            self.discount = discount
        }
        
        if let price = parametersJson["price"]?.intValue
        {
            self.price = price
        }
        
        if let total_price = parametersJson["total_price"]?.intValue
        {
            self.total_price = total_price
        }
        
        if let name_print = parametersJson["name_print"]?.stringValue
        {
            self.name_print = name_print
        }
        
        if let color = parametersJson["color"]?.stringValue
        {
            self.color = color
        }
        
        if let weight = parametersJson["weight"]?.stringValue
        {
            self.weight = weight
        }
        
        if let image = parametersJson["image"]?.stringValue
        {
            self.image = image
        }
    }
}
