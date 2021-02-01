//
//  CalenderModel.swift
//  AlAhliFC
//
//  Created by Basma on 9/17/19.
//  Copyright © 2019 me. All rights reserved.
//

import Foundation
import SwiftyJSON

class CalenderModel : NSObject {
    var name:String?
    var content:String?
    var link:String?
    var date:String?
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
        
        if let date = parametersJson["date"]?.stringValue
        {
            self.date = date
        }
        
        if let image = parametersJson["image"]?.stringValue
        {
            self.image = image
        }
    }
}
