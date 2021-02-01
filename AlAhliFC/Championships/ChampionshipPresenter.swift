//
//  ChampionshipPresenter.swift
//  AlAhliFC
//
//  Created by Basma on 9/3/19.
//  Copyright © 2019 me. All rights reserved.
//

import Foundation

class ChampionshipPrestenter {
    
    func getChamps(onSuccess: @escaping ([Championships], [Teams]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getChampioships()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage()
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    var champs = [Championships]()
                    if let data = response!["data"]["data"].array {
                        for cteams in data {
                            champs.append(Championships(parametersJson: cteams.dictionaryValue))
                        }
                    }else{
                        onFailure("Oops, Error occured")
                    }
                    var teamsList = [Teams]()
                    if let teams = response!["data"]["teams"].array {
                        for cteams in teams {
                            teamsList.append(Teams(parametersJson: cteams.dictionaryValue))
                        }
                    }else{
                        onFailure("Oops, Error occured")
                    }
                    onSuccess(champs, teamsList)

                    
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
