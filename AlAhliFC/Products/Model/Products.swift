//
//  Products.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/9/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SwiftyJSON

class Products: NSObject {
    
    var link:String?
    var cat_link:String?
    var cat_name:String?
    var name:String?
    var star_rate:Int?
    var rate:Int?
    var number_prod:Int?
    var sale_number_prod:Int?
    var valid_number_prod:Int?
    var discount:Int?
    var price:Int?
    var total_price:Int?
    var image:String?
    var another_image = [String]()
    var fees = [Fees]()
    var dec_prod:[DecProduct]?
    var productColors = [ProductColor]()
    var productWeights = [ProductWeight]()
    var city_made:String?
    var desc:String?

    
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
        
        if let star_rate = parametersJson["star_rate"]?.intValue
        {
            self.star_rate = star_rate
        }
        
        if let rate = parametersJson["rate"]?.intValue
        {
            self.rate = rate
        }
        
        if let number_prod = parametersJson["number_prod"]?.intValue
        {
            self.number_prod = number_prod
        }
        
        if let sale_number_prod = parametersJson["sale_number_prod"]?.intValue
        {
            self.sale_number_prod = sale_number_prod
        }
        
        if let valid_number_prod = parametersJson["valid_number_prod"]?.intValue
        {
            self.valid_number_prod = valid_number_prod
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
        
        if let image = parametersJson["image"]?.stringValue
        {
            self.image = image
        }
        
        if let another_image = parametersJson["another_image"]?.arrayValue
        {
            for image in another_image {
                self.another_image.append(image["name"].stringValue)
            }
        }
        
        if let fees = parametersJson["fees"]?.arrayValue
        {
            for fee in fees {
                self.fees.append(Fees(parametersJson: fee.dictionaryValue))
            }
        }
        
        if let dec_prod = parametersJson["dec_prod"]?.arrayValue
        {
            for prod in dec_prod {
                self.dec_prod?.append(DecProduct(parametersJson: prod.dictionaryValue))
            }
        }
        
        if let productColor = parametersJson["color"]?.arrayValue
        {
            for color in productColor {
                self.productColors.append(ProductColor(parametersJson: color.dictionaryValue))
            }
        }
        
        if let productWeight = parametersJson["weight"]?.arrayValue
        {
            for weight in productWeight {
                self.productWeights.append(ProductWeight(parametersJson: weight.dictionaryValue))
            }
        }
        
        if let city_made = parametersJson["city_made"]?.stringValue
        {
            self.city_made = city_made
        }
        
        if let description = parametersJson["description"]?.stringValue
        {
            self.desc = description
        }
    }
}
