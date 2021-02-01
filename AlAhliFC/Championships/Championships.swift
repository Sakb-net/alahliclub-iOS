//
//  ChampsModel.swift
//  AlAhliFC
//
//  Created by Basma on 9/4/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SwiftyJSON

class Championships : NSObject{
    var type:String?
    var link:String?
    var name:String?
    var user_image:String?
    var user_type:String?
    var content:String?
    var created_at:String?
    var national:String?
    var age:String?
    var birthdate:String?
    var location:String?
    var weight:String?
    var height:String?
    var num_sport:String?
    var sport:String?
    var icon_image:String?

    
    override init() {
    }
    
    init(parametersJson: [String: JSON])
    {
        if let type = parametersJson["type"]?.stringValue
        {
            self.type = type
        }
        
        if let link = parametersJson["link"]?.stringValue
        {
            self.link = link
        }
        
        if let name = parametersJson["name"]?.stringValue
        {
            self.name = name
        }
        
        if let user_image = parametersJson["user_image"]?.stringValue
        {
            self.user_image = user_image
        }
        
        if let user_type = parametersJson["user_type"]?.stringValue
        {
            self.user_type = user_type
        }
        
        if let content = parametersJson["content"]?.stringValue
        {
            self.content = content
        }
        
        if let created_at = parametersJson["created_at"]?.stringValue
        {
            self.created_at = created_at
        }
        if let national = parametersJson["national"]?.stringValue
        {
            self.national = national
        }
        
        if let age = parametersJson["age"]?.stringValue
        {
            self.age = age
        }
        
        if let birthdate = parametersJson["birthdate"]?.stringValue
        {
            self.birthdate = birthdate
        }
        
        if let location = parametersJson["location"]?.stringValue
        {
            self.location = location
        }
        
        if let weight = parametersJson["weight"]?.stringValue
        {
            self.weight = weight
        }
        
        if let height = parametersJson["height"]?.stringValue
        {
            self.height = height
        }
        
        if let num_sport = parametersJson["num_sport"]?.stringValue
        {
            self.num_sport = num_sport
        }
        
        if let sport = parametersJson["sport"]?.stringValue
        {
            self.sport = sport
        }
        
        if let icon_image = parametersJson["icon_image"]?.stringValue
        {
            self.icon_image = icon_image
        }
    }
}
