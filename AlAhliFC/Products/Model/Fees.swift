//
//  Fees.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/9/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SwiftyJSON

class Fees: NSObject {
    
    var link:String?
    var name:String?
    var type_price:String?
    var price:Int?
    var total_price:Int?

    override init() {
    }
    
    init(parametersJson: [String: JSON])
    {
        if let link = parametersJson["link"]?.stringValue
        {
            self.link = link
        }
        
        if let name = parametersJson["name"]?.stringValue
        {
            self.name = name
        }
        
        if let type_price = parametersJson["type_price"]?.stringValue
        {
            self.type_price = type_price
        }
        
        if let price = parametersJson["price"]?.intValue
        {
            self.price = price
        }
        
        if let total_price = parametersJson["total_price"]?.intValue
        {
            self.total_price = total_price
        }
    }
}
