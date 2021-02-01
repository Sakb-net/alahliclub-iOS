//
//  CartHeaderCell.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/18/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class CartHeaderCell: UITableViewCell {
    
    @IBOutlet weak var headerTitle: UILabel!
    
    func configCell(title:String){
        headerTitle.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        headerTitle.textColor = Color.lightText.value
        
        headerTitle.text = title
    }
    
    
}
