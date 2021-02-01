//
//  CartReceiptCell.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/18/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class CartReceiptCell: UITableViewCell {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var orderNowBtn: UIButton!
    @IBOutlet weak var containerStack: UIStackView!

    var totalFees = 0
    
    func configCell(cartFees:[Fees], cartTotalPrice:Int){
        containerStack.removeAllArrangedSubviews()
        
        
        let cartPriceStack   = UIStackView()
        cartPriceStack.axis  = .horizontal
        cartPriceStack.distribution  = .fillProportionally
        cartPriceStack.alignment = .fill
        cartPriceStack.spacing   = 4
        
        let cartPriceName = UILabel()
        cartPriceName.textColor = Color.darkText.value
        cartPriceName.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        cartPriceName.text  = "تكلفة السلة"
        cartPriceName.textAlignment = .right
        
        let cartPriceValue = UILabel()
        cartPriceValue.textColor = Color.darkText.value
        cartPriceValue.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        cartPriceValue.text  = String(cartTotalPrice) + "ر.س"
        cartPriceValue.textAlignment = .left
        
        cartPriceStack.addArrangedSubview(cartPriceValue)
        cartPriceStack.addArrangedSubview(cartPriceName)
        
        containerStack.addArrangedSubview(cartPriceStack)
        totalFees = 0
        for cartFee in cartFees {
            
            totalFees += cartFee.total_price ?? 0
            
            let stackView   = UIStackView()
            stackView.axis  = .horizontal
            stackView.distribution  = .fillProportionally
            stackView.alignment = .fill
            stackView.spacing   = 4
            
            let feeName = UILabel()
            feeName.textColor = Color.darkText.value
            feeName.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
            feeName.text  = cartFee.name
            feeName.textAlignment = .right
            
            let feeValue = UILabel()
            feeValue.textColor = Color.darkText.value
            feeName.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
            feeValue.text  = String(cartFee.total_price ?? 0)
            feeValue.textAlignment = .left
            
            stackView.addArrangedSubview(feeValue)
            stackView.addArrangedSubview(feeName)
            
            containerStack.addArrangedSubview(stackView)
        }
        
        let cartPriceAfterAddingFees   = UIStackView()
        cartPriceAfterAddingFees.axis  = .horizontal
        cartPriceAfterAddingFees.distribution  = .fillProportionally
        cartPriceAfterAddingFees.alignment = .fill
        cartPriceAfterAddingFees.spacing   = 4
        
        let totalPriceAfterFeeName = UILabel()
        totalPriceAfterFeeName.textColor = Color.darkText.value
        totalPriceAfterFeeName.font = UIFont(name: AppFont().appFontBold, size: FontSizes().normalFontSize)
        totalPriceAfterFeeName.text  = "المبلغ الكلي"
        totalPriceAfterFeeName.textAlignment = .right
        
        let totalPriceAfterFeeValue = UILabel()
        totalPriceAfterFeeValue.textColor = Color.darkText.value
        totalPriceAfterFeeValue.font = UIFont(name: AppFont().appFontBold, size: FontSizes().normalFontSize)
        totalPriceAfterFeeValue.text  = String(cartTotalPrice + totalFees) + "ر.س"
        totalPriceAfterFeeValue.textAlignment = .left
        
        cartPriceAfterAddingFees.addArrangedSubview(totalPriceAfterFeeValue)
        cartPriceAfterAddingFees.addArrangedSubview(totalPriceAfterFeeName)
        
        containerStack.addArrangedSubview(cartPriceAfterAddingFees)
        
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        
        applyDesign()
    }
    
    func applyDesign(){
        
        container.layer.cornerRadius = 5
        container.layer.borderWidth = 1
        container.layer.borderColor = Color.border.value.cgColor
        
        orderNowBtn.setTitleColor(UIColor.white, for: .normal)
        orderNowBtn.titleLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().largeFontSize)
        orderNowBtn.layer.cornerRadius = 10
        orderNowBtn.backgroundColor = Color.theme.value
    }
    
}
