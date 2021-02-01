//
//  AboutClub.swift
//  AlAhliFC
//
//  Created by Basma on 9/16/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SwiftyJSON

class AboutClub : NSObject{
    
    var name:String?
    var title_one:String?
    var content_one:String?
    var title_two:String?
    var content_two:String?
    var image:String?
    var all_list:[String]?
    
    override init() {
    }
    
    init(parametersJson: [String: JSON])
    {
        if let name = parametersJson["name"]?.stringValue
        {
            self.name = name
        }
        
        if let title_one = parametersJson["title_one"]?.stringValue
        {
            self.title_one = title_one
        }
        
        if let content_one = parametersJson["content_one"]?.stringValue
        {
            self.content_one = content_one
        }
        
        if let title_two = parametersJson["title_two"]?.stringValue
        {
            self.title_two = title_two
        }
        
        if let content_two = parametersJson["content_two"]?.stringValue
        {
            self.content_two = content_two
        }
        
        if let image = parametersJson["image"]?.stringValue
        {
            self.image = image
        }
        
        if let all_list = parametersJson["all_list"]?.array
        {
            var alllist = [String]()
            for item in all_list {
                alllist.append(item.stringValue)
            }
            self.all_list = alllist
        }
    }
}
