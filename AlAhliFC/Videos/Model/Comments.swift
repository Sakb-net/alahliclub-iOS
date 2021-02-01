//
//  Comments.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/10/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SwiftyJSON

class Comments: NSObject {
    var parent_id:String?
    var parent_user_name:String?
    var parent_user_image:String?
    var content:String?
    var image:String?
    var video:String?
    var audio:String?
    var like:String?
    var num_like:String?
    var owner_data:String?
    var star_rate:String?
    var date:String?
    var link:String?
    
    
    override init() {
    }
    
    init(parametersJson: [String: JSON])
    {
        if let parent_id = parametersJson["parent_id"]?.stringValue
        {
            self.parent_id = parent_id
        }
        
        if let parent_user_name = parametersJson["parent_user_name"]?.stringValue
        {
            self.parent_user_name = parent_user_name
        }
        
        if let parent_user_image = parametersJson["parent_user_image"]?.stringValue
        {
            self.parent_user_image = parent_user_image
        }
        
        if let content = parametersJson["content"]?.stringValue
        {
            self.content = content
        }
        
        if let image = parametersJson["image"]?.stringValue
        {
            self.image = image
        }
        
        if let video = parametersJson["video"]?.stringValue
        {
            self.video = video
        }
        
        if let audio = parametersJson["audio"]?.stringValue
        {
            self.audio = audio
        }
        
        if let like = parametersJson["like"]?.stringValue
        {
            self.like = like
        }
        
        if let num_like = parametersJson["num_like"]?.stringValue
        {
            self.num_like = num_like
        }
        
        if let owner_data = parametersJson["owner_data"]?.stringValue
        {
            self.owner_data = owner_data
        }
        
        if let star_rate = parametersJson["star_rate"]?.stringValue
        {
            self.star_rate = star_rate
        }
        
        if let date = parametersJson["date"]?.stringValue
        {
            self.date = date
        }
        
        if let link = parametersJson["link"]?.stringValue
        {
            self.link = link
        }
    }
    
}

class created_at : NSObject{
    var date : String?
    var timezone_type : String?
    var timezone : String?
    
    init(parametersJson: [String: JSON])
    {
        if let date = parametersJson["date"]?.stringValue
        {
            self.date = date
        }
        
        if let timezone_type = parametersJson["timezone_type"]?.stringValue
        {
            self.timezone_type = timezone_type
        }
        
        if let timezone = parametersJson["timezone"]?.stringValue
        {
            self.timezone = timezone
        }
    }
}
