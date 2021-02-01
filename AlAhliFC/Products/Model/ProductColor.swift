//
//  Color.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/9/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProductColor: NSObject {

    var name:String?
    
    override init() {
    }
    
    init(parametersJson: [String: JSON])
    {
        if let name = parametersJson["name"]?.stringValue
        {
            self.name = name
        }
    }
}
