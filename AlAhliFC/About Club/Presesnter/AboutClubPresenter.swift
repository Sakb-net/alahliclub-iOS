//
//  AboutClubPresenter.swift
//  AlAhliFC
//
//  Created by Basma on 9/16/19.
//  Copyright © 2019 me. All rights reserved.
//

import Foundation
class AboutClubPresenter {
    func getAboutClub(onSuccess: @escaping (AboutClub) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getAboutClub()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage()
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    let data = response!["data"]
                    let aboutClub = AboutClub(parametersJson: data.dictionaryValue)
                    onSuccess(aboutClub)
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
