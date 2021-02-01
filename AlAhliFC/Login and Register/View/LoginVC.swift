//
//  LoginVC.swift
//  StarterProject
//
//  Created by Mohammed Saleh on 2/6/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class LoginVC: ParentViewController {
    
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet var textFiledContainer: [UIView]!
    @IBOutlet var textFileds: [UITextField]!
    @IBOutlet weak var rememberMeTitl: UILabel!
    @IBOutlet weak var forgetPassword: UIButton!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var haveAccount: UILabel!
    @IBOutlet weak var createAccount: UIButton!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var isRememberMe:Bool = true
    let presenter = LoginRegisterPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "تسجيل دخول"
        
        menuBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        menuBtn.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        
        menuBtn.addTarget(self, action: #selector(self.openSideMenu), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuBtn)
        
        applyDesign()
        
        if let _ =  UserDefaults.standard.value(forKey: "isRememberMe") as? Bool {
            email.text = UserDefaults.standard.value(forKey: "email") as? String
            password.text = UserDefaults.standard.value(forKey: "password") as? String
        }
    }
    
    @IBAction func remeberMe(_ sender: UISwitch) {
        if sender.isOn {
            isRememberMe = true
        }else{
            isRememberMe = false
        }
    }
    
    @IBAction func forgetPassword(_ sender: UIButton) {
        performSegue(withIdentifier: "toForget", sender: nil)
    }
    
    @IBAction func login(_ sender: UIButton) {
        if isNetworkReachable {
            userLogin()
        }else{
            self.showAlert(title: "أنت غير متصل الإنترنت", message: "", shouldpop: false)
        }
    }
    
    @IBAction func toCreateAccount(_ sender: UIButton) {
        performSegue(withIdentifier: "toRegister", sender: nil)
    }
    
    func userLogin(){
        guard let emailAddress = self.email.text, emailAddress != "" else {
            self.showAlert(title: "", message: "الرجاء إدخال اسم المستخدم او البريد الالكتروني", shouldpop: false)
            return
        }
        
        guard let pass = self.password.text, pass != "" else {
            self.showAlert(title: "", message: "الرجاء إدخال كلمة المرور", shouldpop: false)
            return
        }
        
        self.showLoader()
        presenter.userLogin(email: emailAddress, password: pass, onSuccess: { (userInfo) in
            self.hideLoader()
            
            if self.isRememberMe {
                UserDefaults.standard.set(true, forKey: "isRememberMe")
                UserDefaults.standard.set(emailAddress, forKey: "email")
                UserDefaults.standard.set(pass, forKey: "password")
            }
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = Storyboard().mainStoryboard.instantiateInitialViewController()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func applyDesign(){
        screenTitle.font = UIFont(name: AppFont().appFontBold, size: 25)
        
        for filed in textFiledContainer {
            filed.layer.cornerRadius = 10
            filed.layer.borderWidth = 1
            filed.layer.borderColor = Color.border.value.cgColor
        }
        
        for filed in textFileds {
            filed.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
            filed.textColor = Color.darkText.value
        }
        
        rememberMeTitl.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        rememberMeTitl.textColor = Color.theme.value
        
        haveAccount.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        haveAccount.textColor = Color.darkText.value
        
        forgetPassword.titleLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        forgetPassword.setTitleColor(Color.theme.value, for: .normal)
        
        createAccount.titleLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        createAccount.setTitleColor(Color.theme.value, for: .normal)
        
        login.backgroundColor = Color.theme.value
        login.layer.cornerRadius = 10
        login.titleLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        login.setTitleColor(UIColor.white, for: .normal)
        
    }
    
    //Side Menu
    @objc func openSideMenu(_ sender: UIButton) {
        performSegue(withIdentifier: "openMenu", sender: nil)
    }
}
