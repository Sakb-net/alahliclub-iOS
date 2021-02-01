//
//  ForgetPassword.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 6/30/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class ForgetPassword: ParentViewController {
    
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var hintText: UILabel!
    @IBOutlet weak var textFiledContainer: UIView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var forgetPasword: UIButton!
    @IBOutlet weak var containerView: CardView!
    
    let presenter = LoginRegisterPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyDesign()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let touchedView = touch.view, touchedView != containerView {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    
    
    func applyDesign(){
        screenTitle.font = UIFont(name: AppFont().appFontBold, size: 25)
        
        textFiledContainer.layer.cornerRadius = 10
        textFiledContainer.layer.borderWidth = 1
        textFiledContainer.layer.borderColor = Color.border.value.cgColor
        
        email.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        email.textColor = Color.darkText.value
        
        hintText.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().smallFontSize)
        hintText.textColor = Color.lightText.value
        
        forgetPasword.backgroundColor = Color.theme.value
        forgetPasword.layer.cornerRadius = 10
        forgetPasword.titleLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        forgetPasword.setTitleColor(UIColor.white, for: .normal)
        
    }
}
