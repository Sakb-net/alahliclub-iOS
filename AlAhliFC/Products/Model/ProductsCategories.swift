//
//  ProductsCategories.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/13/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProductsCategories: NSObject {

    var name:String?
    var content:String?
    var link:String?
    var products_count:Int?
    var image:String?
    
    override init() {
    }
    
    init(parametersJson: [String: JSON])
    {
        if let name = parametersJson["name"]?.stringValue
        {
            self.name = name
        }
        
        if let content = parametersJson["content"]?.stringValue
        {
            self.content = content
        }
        
        if let link = parametersJson["link"]?.stringValue
        {
            self.link = link
        }
        
        if let products_count = parametersJson["products_count"]?.intValue
        {
            self.products_count = products_count
        }
        
        if let image = parametersJson["image"]?.stringValue
        {
            self.image = image
        }
    }
}
