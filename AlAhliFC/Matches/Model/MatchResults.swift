//
//  MatchResults.swift
//  AlAhliFC
//
//  Created by Basma on 9/21/19.
//  Copyright © 2019 me. All rights reserved.
//

import Foundation
import SwiftyJSON

class MatchResults : NSObject {
    var link:String?
    var link_ticket:String?
    var name:String?
    var date:String?
    var time:String?
    var start_booking:String?
    var end_booking:String?
    var first_team:String?
    var second_team:String?
    var first_goal:String?
    var second_goal:String?
    var first_image:String?
    var second_image:String?
    var id:String?
    var desc:String?
    var cart_yellow1:String?
    var cart_yellow2:String?
    var cart_red1:String?
    var cart_red2:String?
    var offside1:String?
    var offside2:String?
    var strikes1:String?
    var strikes2:String?
    var paying_goal1:String?
    var paying_goal2:String?
    var passes1:String?
    var passes2:String?
    var type_time:String?
    var video:String?
    var upload:String?
    var data_first: [datafirst]?
    var data_second: [datafirst]?
    override init() {
    }
    
    init(parametersJson: [String: JSON])
    {
        if let link = parametersJson["link"]?.stringValue
        {
            self.link = link
        }
        
        if let link_ticket = parametersJson["link_ticket"]?.stringValue
        {
            self.link_ticket = link_ticket
        }
        
        if let name = parametersJson["name"]?.stringValue
        {
            self.name = name
        }
        
        if let date = parametersJson["date"]?.stringValue
        {
            self.date = date
        }
        
        if let time = parametersJson["time"]?.stringValue
        {
            self.time = time
        }
        
        if let start_booking = parametersJson["start_booking"]?.stringValue
        {
            self.start_booking = start_booking
        }
        
        if let end_booking = parametersJson["end_booking"]?.stringValue
        {
            self.end_booking = end_booking
        }
        if let first_team = parametersJson["first_team"]?.stringValue
        {
            self.first_team = first_team
        }
        
        if let second_team = parametersJson["second_team"]?.stringValue
        {
            self.second_team = second_team
        }
        
        if let first_goal = parametersJson["first_goal"]?.stringValue
        {
            self.first_goal = first_goal
        }
        
        if let second_goal = parametersJson["second_goal"]?.stringValue
        {
            self.second_goal = second_goal
        }
        
        if let first_image = parametersJson["first_image"]?.stringValue
        {
            self.first_image = first_image
        }
        
        if let second_image = parametersJson["second_image"]?.stringValue
        {
            self.second_image = second_image
        }

        if let id = parametersJson["id"]?.stringValue
        {
            self.id = id
        }
        
        if let desc = parametersJson["description"]?.stringValue
        {
            self.desc = desc
        }
        
        if let cart_yellow1 = parametersJson["cart_yellow1"]?.stringValue
        {
            self.cart_yellow1 = cart_yellow1
        }
        
        if let cart_yellow2 = parametersJson["cart_yellow2"]?.stringValue
        {
            self.cart_yellow2 = cart_yellow2
        }
        
        if let cart_red1 = parametersJson["cart_red1"]?.stringValue
        {
            self.cart_red1 = cart_red1
        }
        
        if let cart_red2 = parametersJson["cart_red2"]?.stringValue
        {
            self.cart_red2 = cart_red2
        }
        
        if let offside1 = parametersJson["offside1"]?.stringValue
        {
            self.offside1 = offside1
        }
        
        if let offside2 = parametersJson["offside2"]?.stringValue
        {
            self.offside2 = offside2
        }
        
        if let strikes1 = parametersJson["strikes1"]?.stringValue
        {
            self.strikes1 = strikes1
        }
        if let strikes2 = parametersJson["strikes2"]?.stringValue
        {
            self.strikes2 = strikes2
        }
        if let paying_goal1 = parametersJson["paying_goal1"]?.stringValue
        {
            self.paying_goal1 = paying_goal1
        }
        
        if let paying_goal2 = parametersJson["paying_goal2"]?.stringValue
        {
            self.paying_goal2 = paying_goal2
        }
        
        if let passes1 = parametersJson["passes1"]?.stringValue
        {
            self.passes1 = passes1
        }
        
        if let passes2 = parametersJson["passes2"]?.stringValue
        {
            self.passes2 = passes2
        }
        
        if let type_time = parametersJson["type_time"]?.stringValue
        {
            self.type_time = type_time
        }
        
        if let video = parametersJson["video"]?.stringValue
        {
            self.video = video
        }
        if let upload = parametersJson["upload"]?.stringValue
        {
            self.upload = upload
        }
        if let data_first = parametersJson["data_first"]?.array
        {
            var dfirst = [datafirst]()
            for item in data_first {
                dfirst.append(datafirst(parametersJson: item.dictionaryValue))
            }
            self.data_first = dfirst
        }
        
        if let data_second = parametersJson["data_second"]?.array
        {
            var dfirst = [datafirst]()
            for item in data_second {
                dfirst.append(datafirst(parametersJson: item.dictionaryValue))
            }
            self.data_second = dfirst
        }
    }
}
class datafirst : NSObject{
        var name_player:String?
        var time_player:String?
    init(parametersJson: [String: JSON])
    {
    if let name_player = parametersJson["name_player"]?.stringValue
        {
            self.name_player = name_player
    }
    if let time_player = parametersJson["time_player"]?.stringValue
        {
            self.time_player = time_player
    }
    }
    
}


