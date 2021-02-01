//
//  anwsers.swift
//  AlAhliFC
//
//  Created by Basma on 9/19/19.
//  Copyright © 2019 me. All rights reserved.
//

import Foundation
import SwiftyJSON

class anwsers : NSObject{

    var name:String?
    var rate:String?
    var link:String?
    var created_at:String?
    
    override init() {
    }
    
    init(parametersJson: [String: JSON])
    {
        if let name = parametersJson["name"]?.stringValue
        {
            self.name = name
        }
        
        if let rate = parametersJson["rate"]?.stringValue
        {
            self.rate = rate
        }
        
        if let link = parametersJson["link"]?.stringValue
        {
            self.link = link
        }
        
        if let created_at = parametersJson["created_at"]?.stringValue
        {
            self.created_at = created_at
        }
    }
}
