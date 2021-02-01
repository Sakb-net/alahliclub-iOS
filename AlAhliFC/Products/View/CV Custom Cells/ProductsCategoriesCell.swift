//
//  ProductsCategoriesCell.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/1/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SDWebImage

class ProductsCategoriesCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameContianer: UIView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    func configCell(cat:ProductsCategories){
        applyDesign()
        bgImage.sd_setImage(with: URL(string: Urls.baseUrl + (cat.image ?? "")), placeholderImage: UIImage(named: "placeholder"))
        productName.text = cat.name
    }
    
    func applyDesign(){
        containerView.layer.cornerRadius = 5
        containerView.layer.borderColor = Color.border.value.cgColor
        containerView.layer.borderWidth = 1
        
        bgImage.layer.cornerRadius = 5
        bgImage.clipsToBounds = true
        nameContianer.layer.cornerRadius = 5
    
        productName.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().smallFontSize)
    }
    
    
}
