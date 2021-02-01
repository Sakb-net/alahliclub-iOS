//
//  CartPresenter.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/18/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class CartPresenter: NSObject {

    func getCartProducts(onSuccess: @escaping ([CartItems], [Fees], Int) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getCartProductsURL()
        print(User.shared().access_token)
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage()
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    let data = response!["data"].dictionaryValue
                    var items = [CartItems]()
                    var cartFees = [Fees]()
                    if let prods = data["product_cart"]?.array {
                        for product in prods {
                            items.append(CartItems(parametersJson: product.dictionaryValue))
                        }
                    }else{
                        onFailure("Oops, Error occured")
                    }
                    
                    if let fees = response!["cart_fees"].array {
                        for fee in fees {
                            cartFees.append(Fees(parametersJson: fee.dictionaryValue))
                        }
                    }else{
                        onFailure("Oops, Error occured")
                    }
                    
                    let totalPriceCart = data["total_price_cart"]?.intValue ?? 0
                    
                    onSuccess(items, cartFees, totalPriceCart)
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
    
    func addItemToCart(product: Products, quantity:Int, weight:String, onSuccess: @escaping () -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        var feesLinks = [String]()
        for fee in product.fees {
            feesLinks.append(fee.link ?? "")
        }
        print(User.shared().access_token)
        let url = Urls().getAddCartItemsURL()
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage(),
            "link": product.link ?? "",
            "quantity": quantity,
            "weight": weight,
            "fees[]": feesLinks
        ]
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    onSuccess()
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
    
    func deleteItemToCart(itemLink: String, onSuccess: @escaping () -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
       
        let url = Urls().getDeleteCartItemsURL()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage(),
            "link": itemLink
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    onSuccess()
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
    
    func checkout(onSuccess: @escaping (Checkout) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        
        let url = Urls().getCheckoutURL()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage()
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    let checkout = Checkout(parametersJson: response!["data"].dictionaryValue)
                    onSuccess(checkout)
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
    
    func getPaymentStatus(checkoutId:String, onSuccess: @escaping (PaymentStatus) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        
        let url = Urls().getPaymentStatusURL()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage(),
            "checkout_id": checkoutId
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    let paymentStatus = PaymentStatus(parametersJson: response!["data"].dictionaryValue)
                    onSuccess(paymentStatus)
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
