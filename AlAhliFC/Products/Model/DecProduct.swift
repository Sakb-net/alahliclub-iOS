//
//  DecProduct.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/9/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SwiftyJSON

class DecProduct: NSObject {
    
    var weight:String?
    var code:String?
    var price:String?
    var discount:String?

    override init() {
    }
    
    init(parametersJson: [String: JSON])
    {
        if let weight = parametersJson["weight"]?.stringValue
        {
            self.weight = weight
        }
        
        if let code = parametersJson["code"]?.stringValue
        {
            self.code = code
        }
        
        if let price = parametersJson["price"]?.stringValue
        {
            self.price = price
        }
        
        if let discount = parametersJson["discount"]?.stringValue
        {
            self.discount = discount
        }
    }
}
