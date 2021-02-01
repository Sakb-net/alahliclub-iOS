//
//  QuestionDetails.swift
//  AlAhliFC
//
//  Created by Basma on 9/19/19.
//  Copyright © 2019 me. All rights reserved.
//

import Foundation
import SwiftyJSON

class QuestionDetails : NSObject{
    
    var name:String?
    var rate:String?
    var link:String?
    var created_at:String?
    var content:String?
    var questionAnwsers:[anwsers]?
    
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
        if let content = parametersJson["content"]?.stringValue
        {
            self.content = content
        }
        if let allAnwsers = parametersJson["anwsers"]?.array
        {
            var qAnswers = [anwsers]()
            for answer in allAnwsers {
                qAnswers.append(anwsers(parametersJson: answer.dictionaryValue))
            }
            self.questionAnwsers = qAnswers
        }
    }
}
