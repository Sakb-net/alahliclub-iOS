//
//  Checkout.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/21/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SwiftyJSON

class Checkout: NSObject {

    var ok_chechout:Int?
    var customer_givenName:String?
    var billing_postcode:String?
    var customer_surname:String?
    var billing_country:String?
    var billing_state:String?
    var billing_city:String?
    var billing_street1:String?
    var customer_email:String?
    var testMode:String?
    var merchantTransactionId:String?
    var checkoutId:String?
    var shopperResultUrl:String?
    
    
    override init() {
    }
    
    init(parametersJson: [String: JSON])
    {
        if let ok_chechout = parametersJson["ok_chechout"]?.intValue
        {
            self.ok_chechout = ok_chechout
        }
        
        if let customer_givenName = parametersJson["customer_givenName"]?.stringValue
        {
            self.customer_givenName = customer_givenName
        }
        
        if let billing_postcode = parametersJson["billing_postcode"]?.stringValue
        {
            self.billing_postcode = billing_postcode
        }
        
        if let customer_surname = parametersJson["customer_surname"]?.stringValue
        {
            self.customer_surname = customer_surname
        }
        
        if let billing_country = parametersJson["billing_country"]?.stringValue
        {
            self.billing_country = billing_country
        }
        
        if let billing_state = parametersJson["billing_state"]?.stringValue
        {
            self.billing_state = billing_state
        }
        
        if let billing_city = parametersJson["billing_city"]?.stringValue
        {
            self.billing_city = billing_city
        }
        
        if let billing_street1 = parametersJson["billing_street1"]?.stringValue
        {
            self.billing_street1 = billing_street1
        }
        
        if let customer_email = parametersJson["customer_email"]?.stringValue
        {
            self.customer_email = customer_email
        }
        
        if let testMode = parametersJson["testMode"]?.stringValue
        {
            self.testMode = testMode
        }
        
        if let merchantTransactionId = parametersJson["merchantTransactionId"]?.stringValue
        {
            self.merchantTransactionId = merchantTransactionId
        }
        
        if let checkoutId = parametersJson["checkoutId"]?.stringValue
        {
            self.checkoutId = checkoutId
        }
        
        if let shopperResultUrl = parametersJson["shopperResultUrl"]?.stringValue
        {
            self.shopperResultUrl = shopperResultUrl
        }
    }
}
