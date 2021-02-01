//
//  ProductsPresenter.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/13/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class ProductsPresenter: NSObject {
    
    func getCategories(numPage:Int, onSuccess: @escaping ([ProductsCategories]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getCategoriesURL()
        
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
                        var categories = [ProductsCategories]()
                        for category in data {
                            categories.append(ProductsCategories(parametersJson: category.dictionaryValue))
                        }
                        onSuccess(categories)
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
    
    func getProducts(catLink:String, numPage:Int, valSort:String, onSuccess: @escaping ([Products]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getProductsURL()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage(),
            "cat_link": catLink,
            "val_sort": valSort
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                     let data = response!["data"].dictionaryValue
                     var products = [Products]()
                    if let prods = data["products"]?.array {
                        for product in prods {
                            products.append(Products(parametersJson: product.dictionaryValue))
                        }
                        onSuccess(products)
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
