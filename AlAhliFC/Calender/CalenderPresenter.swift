//
//  CalenderPresenter.swift
//  AlAhliFC
//
//  Created by Basma on 9/17/19.
//  Copyright © 2019 me. All rights reserved.
//

import Foundation

class CalenderPresenter {
    
    func getCalendars(onSuccess: @escaping ([CalenderModel]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getCalender()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage()
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    if let data = response!["data"]["data"].array {
                        var calenderModels = [CalenderModel]()
                        for item in data {
                            calenderModels.append(CalenderModel(parametersJson: item.dictionaryValue))
                        }
                        onSuccess(calenderModels)
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
