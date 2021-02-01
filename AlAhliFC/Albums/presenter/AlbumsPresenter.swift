//
//  AlbumsPresenter.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/9/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class AlbumsPresenter: NSObject {
    
    func getAlbums(numPage:Int, onSuccess: @escaping ([Albums]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getAlbumsURL()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage(),
            "num_page": numPage
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    if let data = response!["data"].array {
                        var albums = [Albums]()
                        for album in data {
                            albums.append(Albums(parametersJson: album.dictionaryValue))
                        }
                        onSuccess(albums)
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
    
    func getAlbumImages(albumsLink:String, onSuccess: @escaping (Albums, [Albums]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getAlbumImagesURL()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage(),
            "albums_link": albumsLink
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    
                    var albumData = Albums()
                    var albumImages = [Albums]()
                    
                    let data = response!["data"]
                    albumData = Albums(parametersJson: data.dictionaryValue)
                    
                    let images = response!["sub_albums"].arrayValue
                    for image in images {
                        albumImages.append(Albums(parametersJson: image.dictionaryValue))
                    }
                    
                    onSuccess(albumData, albumImages)
                    
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
