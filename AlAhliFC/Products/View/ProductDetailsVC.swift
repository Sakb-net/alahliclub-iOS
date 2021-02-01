//
//  ProductDetailsVC.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/2/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class ProductDetailsVC: ParentViewController {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var selectSizeTitle: UILabel!
    @IBOutlet var sizeTypes: [UIButton]!
    @IBOutlet weak var selectAmount: UILabel!
    @IBOutlet weak var addMore: UIButton!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var remove: UIButton!
    @IBOutlet weak var addToCart: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    
    var product: Products!
    var numberOfPeices = 1
    var selectedWeight = ""
    var selectedWeightIndex:Int!
    
    let presenter = CartPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyDesign()
        
        productImage.sd_setImage(with: URL(string: Urls.baseUrl + (product.image ?? "")), placeholderImage: UIImage(named: "placeholder"))
        
        productPrice.text = String(product.price ?? 0) + " " + "ر.س"
        
        for i in 0..<product.productWeights .count {
            sizeTypes[i].isHidden = false
            sizeTypes[i].tag = i
            sizeTypes[i].setTitle(product.productWeights[i].name ?? "", for: .normal)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let touchedView = touch.view, touchedView != containerView {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    
    @IBAction func addMore(_ sender: UIButton) {
        numberOfPeices += 1
        amount.text = String(numberOfPeices)
    }
    
    @IBAction func removeItem(_ sender: UIButton) {
        if numberOfPeices == 1 {
            return
        }
        numberOfPeices -= 1
        amount.text = String(numberOfPeices)
    }
    
    @IBAction func selectWeight(_ sender: UIButton) {
        if selectedWeightIndex != nil {
            sizeTypes[selectedWeightIndex].layer.borderColor = Color.border.value.cgColor
            sizeTypes[selectedWeightIndex].layer.borderWidth = 1
            sizeTypes[selectedWeightIndex].setTitleColor(Color.lightText.value, for: .normal)
        }
        selectedWeightIndex = sender.tag
        selectedWeight = product.productWeights[sender.tag].name ?? ""
        sender.layer.borderColor = Color.theme.value.cgColor
        sender.layer.borderWidth = 2
        sender.setTitleColor(Color.theme.value, for: .normal)
    }
    
    
    @IBAction func addToCart(_ sender: UIButton) {
        if isNetworkReachable {
            addItemToCart()
        }else{
            self.showAlert(title: "أنت غير متصل الإنترنت", message: "", shouldpop: false)
        }
    }
    
    func addItemToCart(){
        if UserDefaults.standard.object(forKey: "UserCachedData") == nil{
            self.showAlert(title: "", message: "قم بتسجيل الدخول", shouldpop: false)

        }else if selectedWeight == "" {
            self.showAlert(title: "", message: "ادخل المقاس", shouldpop: false)
        }else {
            self.showLoader()
        presenter.addItemToCart(product: product, quantity: numberOfPeices, weight: selectedWeight, onSuccess: { () in
            
            self.showAlert(title: "", message: "تم إضافة المنتج إلى السلة بنجاح", shouldpop: false)
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
        }
    }
    
    func applyDesign(){
        productImage.layer.cornerRadius = 5
        productImage.clipsToBounds = true
        
        productPrice.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().largeFontSize)
        productPrice.textColor = Color.theme.value
        
        selectSizeTitle.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        selectSizeTitle.textColor = Color.darkText.value
        
        for sizeType in sizeTypes {
            sizeType.titleLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
            sizeType.layer.borderColor = Color.lightText.value.cgColor
            sizeType.layer.borderWidth = 1
            sizeType.setTitleColor(Color.lightText.value, for: .normal)
        }
        
        selectAmount.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        selectAmount.textColor = Color.darkText.value
        
        amount.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        amount.textColor = Color.darkText.value
        
        addMore.titleLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().largeFontSize)
        addMore.setTitleColor(Color.lightText.value, for: .normal)
        
        addMore.layer.cornerRadius = 15
        addMore.layer.borderWidth = 1
        addMore.layer.borderColor = Color.lightText.value.cgColor
        
        remove.titleLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().largeFontSize)
        remove.setTitleColor(Color.lightText.value, for: .normal)
        
        remove.layer.cornerRadius = 15
        remove.layer.borderWidth = 1
        remove.layer.borderColor = Color.lightText.value.cgColor
        
        addToCart.titleLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        addToCart.setTitleColor(UIColor.white, for: .normal)
        
    }
    
}
