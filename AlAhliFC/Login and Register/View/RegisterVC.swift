//
//  RegisterVC.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 6/29/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class RegisterVC: ParentViewController, SelectedDropDownType {

    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet var textFiledContainer: [UIView]!
    @IBOutlet var textFileds: [UITextField]!
    @IBOutlet weak var createAccount: UIButton!
    @IBOutlet weak var haveAccount: UILabel!
    @IBOutlet weak var login: UIButton!
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var district: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    let presenter = LoginRegisterPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "إنشاء حساب"
        applyDesign()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func toLogin(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func CreateAccount(_ sender: UIButton) {
        if isNetworkReachable {
            createAccountAction()
        }else{
            self.showAlert(title: "أنت غير متصل الإنترنت", message: "", shouldpop: false)
        }
    }
    
    func createAccountAction() {
        
        guard let displayName = self.username.text, displayName != "" else {
            self.showAlert(title: "", message: "الرجاء إدخال اسم المستخدم", shouldpop: false)
            return
        }
        
        guard let phone = self.phoneNumber.text, phone != "" else {
            self.showAlert(title: "", message: "الرجاء إدخال رقم التليفون", shouldpop: false)
            return
        }
        
        guard let emailAddress = self.email.text, emailAddress != "" else {
            self.showAlert(title: "", message: "الرجاء إدخال اسم المستخدم او البريد الالكتروني", shouldpop: false)
            return
        }
        
        guard let city = self.city.text, city != "" else {
            self.showAlert(title: "", message: "الرجاء إختيار المدينة", shouldpop: false)
            return
        }
        
        guard let district = self.district.text, district != "" else {
            self.showAlert(title: "", message: "الرجاء إدخال الحي الذي تسكنه", shouldpop: false)
            return
        }
        
        guard let pass = self.password.text, pass != "" else {
            self.showAlert(title: "", message: "الرجاء إدخال كلمة المرور", shouldpop: false)
            return
        }
        
        guard let confirmPass = self.confirmPassword.text, confirmPass != "" else {
            self.showAlert(title: "", message: "الرجاء إدخال تأكيد كلمة المرور", shouldpop: false)
            return
        }
        
        if pass != confirmPass {
            self.showAlert(title: "", message: "كلمة المرور غير متطابقة", shouldpop: false)
            return
        }
        
        self.showLoader()
        presenter.userRegister(email: emailAddress, password: pass, displayName: displayName, phone: phone, city: city, reg_site: district, onSuccess: { (userInfo) in
            self.hideLoader()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = Storyboard().mainStoryboard.instantiateInitialViewController()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func userLogin(){
        
        guard let emailAddress = self.email.text, emailAddress != "" else {
            self.showAlert(title: "", message: "الرجاء إدخال اسم المستخدم او البريد الالكتروني", shouldpop: false)
            return
        }
        
        self.showLoader()
        presenter.forgetPassword(email: emailAddress, onSuccess: { (userInfo) in
            self.hideLoader()
            
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
        
        
        haveAccount.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        haveAccount.textColor = Color.darkText.value
        
        login.titleLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        login.setTitleColor(Color.theme.value, for: .normal)
        
        createAccount.backgroundColor = Color.theme.value
        createAccount.layer.cornerRadius = 10
        createAccount.titleLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        createAccount.setTitleColor(UIColor.white, for: .normal)
        
    }
    
    func selectedType(selectedType: DropDownTypes, selectedItem: Any) {
        if selectedType == .City {
            let selectedCity = selectedItem as! City
            self.city.text = selectedCity.name
        }
    }
    
    @IBAction func openCitiesDropDown(_ sender: UIButton) {
        let dropDownVC = Storyboard().dropDownStoryboard.instantiateViewController(withIdentifier: "DropDownVC") as! DropDownVC
        
        dropDownVC.selectDelegate = self
        dropDownVC.selectedType = .City
        
        present(dropDownVC, animated: true
            , completion: nil)
    }
    
    
}
