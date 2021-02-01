//
//  HelperMethods.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/8/19.
//  Copyright © 2019 me. All rights reserved.
//

import Foundation

class HelperMethods: NSObject {
    
    class func saveCurrentLanguage(currentLanguage: String?)
    {
        let defaults = UserDefaults.standard
        defaults.set(currentLanguage, forKey: "currentLanguage")
    }
    
    class func getCurrentLanguage() -> String
    {
        let defaults = UserDefaults.standard
        if let currentLanguage = defaults.value(forKey: "currentLanguage") as? String {
            return currentLanguage
        }
        return "ar"
    }
}
