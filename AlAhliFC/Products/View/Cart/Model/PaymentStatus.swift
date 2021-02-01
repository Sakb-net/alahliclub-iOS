//
//  PaymentStatus.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/21/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SwiftyJSON

class PaymentStatus: NSObject {

    var mesage_pay:String?
    var back_color:String?
    var ok_pay:Int?
    var reson_description:String?
    
    
    override init() {
    }
    
    init(parametersJson: [String: JSON])
    {
        
        if let mesage_pay = parametersJson["mesage_pay"]?.stringValue
        {
            self.mesage_pay = mesage_pay
        }
        
        if let back_color = parametersJson["back_color"]?.stringValue
        {
            self.back_color = back_color
        }
        
        if let ok_pay = parametersJson["ok_pay"]?.intValue
        {
            self.ok_pay = ok_pay
        }
        
        if let reson_description = parametersJson["reson_description"]?.stringValue
        {
            self.reson_description = reson_description
        }
    }
}
