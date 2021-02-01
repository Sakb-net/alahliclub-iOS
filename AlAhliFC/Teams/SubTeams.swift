//
//  SubTeams.swift
//  AlAhliFC
//
//  Created by Basma on 9/5/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SwiftyJSON

class SubTeams:NSObject {
    var name:String?
    var content:String?
    var link:String?
    var type:String?
    var count_subteam:String?
    
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
        
        if let count_subteam = parametersJson["count_subteam"]?.stringValue
        {
            self.count_subteam = count_subteam
        }
}
}
