//
//  MenuLoginCell.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 6/29/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class MenuLoginCell: UITableViewCell {

    @IBOutlet weak var goToLogin: UILabel!
    
    
    func configCell() {
        applyDesign()
    }

    func applyDesign(){
        goToLogin.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().largeFontSize)
    }
}
