//
//  TeamsPresenter.swift
//  AlAhliFC
//
//  Created by Basma on 9/5/19.
//  Copyright © 2019 me. All rights reserved.
//

import Foundation

class TeamsPresenter {
    func getTeamsDetails(onSuccess: @escaping ([TeamsDetails]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getTeams()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage()
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    var teams = [TeamsDetails]()
                    if let data = response!["data"].array {
                        for team in data {
                            teams.append(TeamsDetails(parametersJson: team.dictionaryValue))
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
                    onSuccess(teams)
                    
                    
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
    
    func getPlayers(team_link : String, onSuccess: @escaping ([Players],[Players], String) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getPlayers()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage(),
            "team_link": team_link
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    var name = ""
                    if let sName = response!["data"]["name"].string{
                        name = sName
                    }
                    var teams = [Players]()
                    if let data = response!["data"]["players"].array {
                        for team in data {
                            teams.append(Players(parametersJson: team.dictionaryValue))
                        }
                    }else{
                        onFailure("Oops, Error occured")
                    }
                    
                    var coachs = [Players]()
                    if let data = response!["data"]["coaches"].array {
                        for coach in data {
                            coachs.append(Players(parametersJson: coach.dictionaryValue))
                        }
                    }else{
                        onFailure("Oops, Error occured")
                    }
                    
                    onSuccess(teams, coachs, name)
                    
                    
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
    func roundedView(view : UIView){
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
    }
}
