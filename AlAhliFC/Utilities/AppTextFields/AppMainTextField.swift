//
//  AppMainTextField.swift
//  StarterProject
//
//  Created by Mohammed Saleh on 2/8/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class AppMainTextField: UITextField
{
    
    @IBInspectable var size:CGFloat = FontSizes().normalFontSize
    
    override func layoutSubviews()
    {
        self.font = UIFont.init(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        self.textColor = Color.theme.value
        self.layer.borderColor = Color.border.value.cgColor
        self.layer.borderWidth = 1
        self.addDoneButtonOnKeyboard()
    }
    
}

