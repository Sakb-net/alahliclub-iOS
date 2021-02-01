//
//  Albums.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/9/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SwiftyJSON

class Albums: NSObject {
    
    var name:String?
    var link:String?
    var image:String?
    var date:String?
    var created_at:String?

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
        
        if let image = parametersJson["image"]?.stringValue
        {
            self.image = image
        }
        
        if let date = parametersJson["date"]?.stringValue
        {
            self.date = date
        }
        
        if let created_at = parametersJson["created_at"]?.stringValue
        {
            self.created_at = created_at
        }
    }
}
