//
//  ModelX.swift
//  StarterProject
//
//  Created by Mohammed Saleh on 2/3/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SwiftyJSON

class NextMatch: NSObject {

    var link:String?
    var first_team:String?
    var second_team:String?
    var first_image:String?
    var second_image:String?
    var date:String?
    var time:String?
    var first_goal:Int?
    var second_goal:Int?
    
    override init() {
    }
    
    init(parametersJson: [String: JSON])
    {
        if let link = parametersJson["link"]?.stringValue
        {
            self.link = link
        }
        
        if let first_team = parametersJson["first_team"]?.stringValue
        {
            self.first_team = first_team
        }
        
        if let second_team = parametersJson["second_team"]?.stringValue
        {
            self.second_team = second_team
        }
        
        if let first_image = parametersJson["first_image"]?.stringValue
        {
            self.first_image = first_image
        }
        
        if let second_image = parametersJson["second_image"]?.stringValue
        {
            self.second_image = second_image
        }
        
        if let date = parametersJson["date"]?.stringValue
        {
            self.date = date
        }
        
        if let time = parametersJson["time"]?.stringValue
        {
            self.time = time
        }
        
        if let first_goal = parametersJson["first_goal"]?.intValue
        {
            self.first_goal = first_goal
        }
        
        if let second_goal = parametersJson["second_goal"]?.intValue
        {
            self.second_goal = second_goal
        }
    }
}
