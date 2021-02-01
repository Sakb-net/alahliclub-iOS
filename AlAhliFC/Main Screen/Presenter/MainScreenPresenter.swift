//
//  ServiceXPresenter.swift
//  StarterProject
//
//  Created by Mohammed Saleh on 2/3/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class MainScreenPresenter: NSObject {

    func getHomeDetails(onSuccess: @escaping (String, NextMatch, PresviousMatch, [News], [Videos], [Albums], [Products]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getHomeURL()
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage()
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    if let data = response!["data"].dictionary {
                        let linkTicket = data["link_ticket"]?.stringValue ?? ""
                        let nextMatch = NextMatch(parametersJson: data["match_next"]?.dictionaryValue ?? [:])
                        let presviousMatch = PresviousMatch(parametersJson: data["match_perv"]?.dictionaryValue ?? [:])
                        var news = [News]()
                        var videos = [Videos]()
                        var albums = [Albums]()
                        var products = [Products]()
                        
                        for newsItem in data["news"]?.arrayValue ?? [] {
                            news.append(News(parametersJson: newsItem.dictionaryValue))
                        }
                        
                        for video in data["videos"]?.arrayValue ?? [] {
                            videos.append(Videos(parametersJson: video.dictionaryValue))
                        }
                        
                        for album in data["albums"]?.arrayValue ?? [] {
                            albums.append(Albums(parametersJson: album.dictionaryValue))
                        }
                        
                        for product in data["products"]?.arrayValue ?? [] {
                            products.append(Products(parametersJson: product.dictionaryValue))
                        }
                        
                         onSuccess(linkTicket, nextMatch, presviousMatch, news, videos, albums, products)
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
                onFailure(error?.localizedDescription)
            }
        }
    }
}
