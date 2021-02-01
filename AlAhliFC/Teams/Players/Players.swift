//
//  File.swift
//  AlAhliFC
//
//  Created by Basma on 9/8/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SwiftyJSON

class Players : NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.content, forKey: "content")
        aCoder.encode(self.name, forKey: "link")
        aCoder.encode(self.content, forKey: "type")
        aCoder.encode(self.name, forKey: "user_image")
        aCoder.encode(self.content, forKey: "user_type")
        aCoder.encode(self.name, forKey: "created_at")
        aCoder.encode(self.content, forKey: "national")
        aCoder.encode(self.name, forKey: "age")
        aCoder.encode(self.content, forKey: "birthdate")
        aCoder.encode(self.name, forKey: "location")
        aCoder.encode(self.content, forKey: "weight")
        aCoder.encode(self.content, forKey: "height")
        aCoder.encode(self.name, forKey: "num_sport")
        aCoder.encode(self.content, forKey: "sport")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = (aDecoder.decodeObject(forKey: "name") as? String) ?? ""
        self.content = (aDecoder.decodeObject(forKey: "content") as? String) ?? ""
        self.link = (aDecoder.decodeObject(forKey: "link") as? String) ?? ""
        self.type = (aDecoder.decodeObject(forKey: "type") as? String) ?? ""
        self.user_image = (aDecoder.decodeObject(forKey: "user_image") as? String) ?? ""
        self.user_type = (aDecoder.decodeObject(forKey: "user_type") as? String) ?? ""
        self.created_at = (aDecoder.decodeObject(forKey: "created_at") as? String) ?? ""
        self.national = (aDecoder.decodeObject(forKey: "national") as? String) ?? ""
        self.age = (aDecoder.decodeObject(forKey: "age") as? String) ?? ""
        self.birthdate = (aDecoder.decodeObject(forKey: "birthdate") as? String) ?? ""
        self.location = (aDecoder.decodeObject(forKey: "location") as? String) ?? ""
        self.weight = (aDecoder.decodeObject(forKey: "weight") as? String) ?? ""
        self.height = (aDecoder.decodeObject(forKey: "height") as? String) ?? ""
        self.num_sport = (aDecoder.decodeObject(forKey: "num_sport") as? String) ?? ""
        self.sport = (aDecoder.decodeObject(forKey: "sport") as? String) ?? ""
    }
    var name:String?
    var content:String?
    var link:String?
    var type:String?
    var user_image:String?
    var user_type:String?
    var created_at:String?
    var national:String?
    var age:String?
    var birthdate:String?
    var location:String?
    var weight:String?
    var height:String?
    var num_sport:String?
    var sport:String?
    
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
        
        if let type = parametersJson["type"]?.stringValue
        {
            self.type = type
        }
        
        if let user_image = parametersJson["user_image"]?.stringValue
        {
            self.user_image = user_image
        }
        
        if let user_type = parametersJson["user_type"]?.stringValue
        {
            self.user_type = user_type
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
}
}
