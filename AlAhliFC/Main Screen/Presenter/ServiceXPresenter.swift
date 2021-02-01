//
//  ServiceXPresenter.swift
//  StarterProject
//
//  Created by Mohammed Saleh on 2/3/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class MainScreenPresenter: NSObject {

    func getHomeDetails(limit:Int, onSuccess: @escaping ([ModelX]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getHomeURL()
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage(),
            "limit": 5
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if((response) != nil)
            {
                if let data = response!["data"].array
                {
                    var levels = [ModelX]()
                    
                    for dic in data
                    {
                        let level = ModelX(parametersJson: dic.dictionaryValue)
                        levels.append(level)
                    }
                    onSuccess(levels)
                }
                else
                {
                    onFailure("Oops, Error occured")
                }
            }
            else
            {
                onFailure("Oops, Error occured")
            }
        }
    }
}
