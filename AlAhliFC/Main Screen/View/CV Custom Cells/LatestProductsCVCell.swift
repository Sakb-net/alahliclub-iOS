//
//  LatestProductsCVCell.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 6/30/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class LatestProductsCVCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var poductImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    func configCell(product: Products){
        applyDesign()
        poductImage.sd_setImage(with: URL(string: Urls.baseUrl + (product.image ?? "")), placeholderImage: UIImage(named: "placeholder"))
        productName.text = product.name
        productPrice.text = String(product.price ?? 0)
        
    }
    
    func applyDesign(){
        containerView.layer.cornerRadius = 5
        containerView.layer.borderColor = Color.border.value.cgColor
        containerView.layer.borderWidth = 1
        poductImage.layer.cornerRadius = 5
        poductImage.clipsToBounds = true
        
        productName.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().smallFontSize)
        productName.textColor = Color.darkText.value
        
        productPrice.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().smallFontSize)
        productPrice.textColor = Color.theme.value
    }
    
}
