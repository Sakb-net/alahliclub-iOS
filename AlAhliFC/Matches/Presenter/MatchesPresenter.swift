//
//  MatchesPresenter.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/11/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class MatchesPresenter: NSObject {

    func getNextMatches(numPage:Int, onSuccess: @escaping ([NextMatch]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getMatchesURL()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage(),
            "num_page": numPage,
            "type": "next"
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    if let data = response!["data"].array {
                        var nextMatches = [NextMatch]()
                        for nextMatch in data {
                            nextMatches.append(NextMatch(parametersJson: nextMatch.dictionaryValue))
                        }
                        onSuccess(nextMatches)
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
    
    func getPreviousMatches(numPage:Int, onSuccess: @escaping ([PresviousMatch]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getMatchesURL()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage(),
            "num_page": numPage,
            "type": "prev"
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    if let data = response!["data"].array {
                        var prevMatches = [PresviousMatch]()
                        for prevMatch in data {
                            prevMatches.append(PresviousMatch(parametersJson: prevMatch.dictionaryValue))
                        }
                        onSuccess(prevMatches)
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
