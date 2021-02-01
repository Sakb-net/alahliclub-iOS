//
//  City.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/11/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SwiftyJSON

class City: NSObject {

    var name:String?
    var key:String?
    
    override init() {
    }
    
    init(parametersJson: [String: JSON])
    {
        if let key = parametersJson["key"]?.stringValue
        {
            self.key = key
        }
        
        if let name = parametersJson["name"]?.stringValue
        {
            self.name = name
        }
    }
}
