//
//  ThemeColor.swift
//  StarterProject
//
//  Created by Mohammed Saleh on 2/4/19.
//  Copyright © 2019 me. All rights reserved.
//
import UIKit

/*
 // Usage Examples
 let shadowColor = Color.shadow.value
 let shadowColorWithAlpha = Color.shadow.withAlpha(0.5)
 let customColorWithAlpha = Color.custom(hexString: "#123edd", alpha: 0.25).value
 */

extension Color {
    
    var value: UIColor {
        var instanceColor = UIColor.clear
        
        switch self {
        case .border:
            instanceColor = UIColor(hexString: "#e6e6e6")
        case .theme:
            instanceColor = UIColor(hexString: "#008640")
        case .lightTheme:
            instanceColor = UIColor(red: 0.0/255, green: 134.0/255, blue: 64.0/255, alpha: 0.07)
        case .shadow:
            instanceColor = UIColor(hexString: "#cccccc")
        case .darkBackground:
            instanceColor = UIColor(hexString: "#999966")
        case .lightBackground:
            instanceColor = UIColor(hexString: "#f4f4f4")
        case .intermidiateBackground:
            instanceColor = UIColor(hexString: "#cccc99")
        case .darkText:
            instanceColor = UIColor(hexString: "#2b2f36")
        case .intermidiateText:
            instanceColor = UIColor(hexString: "#999999")
        case .lightText:
            instanceColor = UIColor(hexString: "#959595")
        case .yellowText:
            instanceColor = UIColor(hexString: "#ffde00")
        case .affirmation:
            instanceColor = UIColor(hexString: "#00ff66")
        case .negation:
            instanceColor = UIColor(hexString: "#ff3300")
        case .badge:
             instanceColor = UIColor(hexString: "#ffa380")
        case .custom(let hexValue, let opacity):
            instanceColor = UIColor(hexString: hexValue).withAlphaComponent(CGFloat(opacity))
        }
        return instanceColor
    }
}
