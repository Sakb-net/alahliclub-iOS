//
//  MenuCell.swift
//  StarterProject
//
//  Created by Mohammed Saleh on 2/8/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var menuItemTitle: UILabel!
    
    func configCell(title:String){
        applyDesign()
        
        self.menuItemTitle.text = title
    }
    
    func applyDesign(){
        menuItemTitle.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().largeFontSize)
        menuItemTitle.textColor = Color.darkText.value
    }
}
