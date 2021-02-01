//
//  Login.swift
//  StarterProject
//
//  Created by Mohammed Saleh on 2/10/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginRegisterPresenter: NSObject {
    
    func userLogin(email:String, password:String, onSuccess: @escaping (User) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getLoginURL()
        
        let parameters:[String:Any] = [
            "email_user_name": email,
            "password": password
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    let data = response!["data"]
                    let user = User(parametersJson: data.dictionaryValue)
                    print(user.access_token)
                    UserDefaults.standard.set(user.access_token, forKey: "access_token")
                    user.saveUser()
                    onSuccess(User.shared())
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
    
    func userRegister(email:String, password:String, displayName:String, phone:String,  city:String, reg_site:String, onSuccess: @escaping (User) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getRegisterURL()
        
        let parameters:[String:Any] = [
            "display_name": displayName,
            "phone": phone,
            "email": email,
            "country": "SA",
            "city": city,
            "state": reg_site,
            "reg_site": reg_site,
            "password": password
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    let data = response!["data"]
                    let user = User(parametersJson: data.dictionaryValue)
                    user.saveUser()
                    onSuccess(User.shared())
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
    
    func forgetPassword(email:String, onSuccess: @escaping (User) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getLoginURL()
        
        let parameters:[String:Any] = [
            "email_user_name": email,
            "password": email
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    let data = response!["data"]
                    let user = User(parametersJson: data.dictionaryValue)
                    user.saveUser()
                    onSuccess(User.shared())
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
