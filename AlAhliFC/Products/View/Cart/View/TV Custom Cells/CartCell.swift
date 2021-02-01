//
//  CartCell.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/18/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SDWebImage

class CartCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemSize: UILabel!
    @IBOutlet weak var amountTite: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var addItem: UIButton!
    @IBOutlet weak var removeItem: UIButton!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var removeFormCartBtn: UIButton!
    
    func configCell(cartItem: CartItems, tag:Int){
        applyDesign()
        
        itemImage.sd_setImage(with: URL(string: Urls.baseUrl + (cartItem.image ?? "")), placeholderImage: UIImage(named: "placeholder"))
        itemName.text = cartItem.name
        itemSize.text = "مقاس" + ": " + (cartItem.weight ?? "")
        amount.text = String(cartItem.quantity ?? 0)
        addItem.tag = tag
        removeItem.tag = tag
        itemPrice.text = String(cartItem.price ?? 0)
        removeFormCartBtn.tag = tag
    }
    
    func applyDesign(){
        container.layer.cornerRadius = 5
        container.layer.borderWidth = 1
        container.layer.borderColor = Color.border.value.cgColor
        
        itemImage.layer.cornerRadius = 5
        itemImage.clipsToBounds = true
        
        itemName.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        itemName.textColor = Color.darkText.value
        
        itemSize.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        itemSize.textColor = Color.darkText.value
        
        amountTite.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        amountTite.textColor = Color.darkText.value
        
        amount.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        amount.textColor = Color.darkText.value
        
        itemPrice.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        itemPrice.textColor = Color.theme.value
        
        addItem.titleLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().largeFontSize)
        addItem.setTitleColor(Color.lightText.value, for: .normal)
        
        addItem.layer.cornerRadius = 15
        addItem.layer.borderWidth = 1
        addItem.layer.borderColor = Color.lightText.value.cgColor
        
        removeItem.titleLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().largeFontSize)
        removeItem.setTitleColor(Color.lightText.value, for: .normal)
        
        removeItem.layer.cornerRadius = 15
        removeItem.layer.borderWidth = 1
        removeItem.layer.borderColor = Color.lightText.value.cgColor
        
        removeFormCartBtn.backgroundColor = Color.border.value
        removeFormCartBtn.titleLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        removeFormCartBtn.setTitleColor(Color.darkText.value, for: .normal)
        removeFormCartBtn.layer.cornerRadius = 5
        
    }
}
