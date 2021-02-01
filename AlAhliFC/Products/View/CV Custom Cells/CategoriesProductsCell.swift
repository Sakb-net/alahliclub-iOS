//
//  CategoriesProductsCell.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/2/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class CategoriesProductsCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameContianer: UIView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    func configCell(product: Products){
        applyDesign()
        
        bgImage.sd_setImage(with: URL(string: Urls.baseUrl + (product.image ?? "")), placeholderImage: UIImage(named: "placeholder"))
        productName.text = product.name
        productPrice.text = String(product.price ?? 0) + " " + "ر.س"
    }
    
    func applyDesign(){
        containerView.layer.cornerRadius = 5
        containerView.layer.borderColor = Color.border.value.cgColor
        containerView.layer.borderWidth = 1
        
        bgImage.layer.cornerRadius = 5
        bgImage.clipsToBounds = true
        nameContianer.layer.cornerRadius = 5
        
        productName.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().smallFontSize)
        productName.textColor = Color.darkText.value
        
        productPrice.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().smallFontSize)
        productPrice.textColor = Color.theme.value
        
    }
}
