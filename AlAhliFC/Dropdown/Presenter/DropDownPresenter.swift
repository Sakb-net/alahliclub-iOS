//
//  DropDownVC.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/12/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SwiftyJSON

class DropDownPresenter: NSObject {

    func getCountries(onSuccess: @escaping (Country) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getCountryURL()
        
        ServiceManager.callAPI(url: url, method: .post, parameters: nil, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    
                    let data = response!["data"]
                    let country = Country(parametersJson: data.dictionaryValue)
                    onSuccess(country)
                    
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
    
    func getCities(onSuccess: @escaping ([City]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getCityURL()
        
        ServiceManager.callAPI(url: url, method: .post, parameters: nil, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    if let data = response!["data"].array {
                        var cities = [City]()
                        for city in data {
                            cities.append(City(parametersJson: city.dictionaryValue))
                        }
                        onSuccess(cities)
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
