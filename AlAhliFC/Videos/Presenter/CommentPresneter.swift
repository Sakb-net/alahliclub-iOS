//
//  CommentPresneter.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/10/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class CommentPresneter: NSObject {
    
    func getComments(link:String, onSuccess: @escaping ([Comments]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getCommentsURL()
        
        let parameters:[String:Any] = [
            "link": link,
            "type": "video",
            "limit": "",
            "lang": "ar"
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    if let data = response!["data"].array {
                        var comments = [Comments]()
                        for comment in data {
                            comments.append(Comments(parametersJson: comment.dictionaryValue))
                        }
                        onSuccess(comments)
                    }else{
                        onFailure("Oops, Error occured")
                    }
                }else{
                    let message = response!["Message"].stringValue
                    onFailure(message)
                }
            }
            else
            {
                onFailure(error!.localizedDescription)
            }
        }
    }
    
    func AddComment(link:String, content:String, user_name: String, onSuccess: @escaping (String) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getAddCommentURL()
        
        let parameters:[String:Any] = [
            "link": link,
            "content": content,
            "user_name": user_name
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    if let message = response!["Message"].string {
                        onSuccess(message)
                    }else{
                        onFailure("Oops, Error occured")
                    }
                }else{
                    let message = response!["Message"].stringValue
                    onFailure(message)
                }
            }
            else
            {
                onFailure(error!.localizedDescription)
            }
        }
    }
}
