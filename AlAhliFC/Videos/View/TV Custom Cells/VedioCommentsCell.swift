//
//  VedioCommentsCell.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/1/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class VedioCommentsCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userComment: UILabel!
    
    
    func configCell(){
        applyDesign()
    }
    
    func applyDesign(){
        userImage.layer.cornerRadius = 20
        userImage.clipsToBounds = true
        
        userName.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        userName.textColor = Color.theme.value
        
        userComment.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().smallFontSize)
        userComment.textColor = Color.darkText.value
        
        
    }

}
