//
//  VedioCommentsHeaderCell.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/1/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class VedioCommentsHeaderCell: UITableViewCell {

    @IBOutlet weak var commentsTitle: UILabel!
    
    func configCell() {
        applyDesign()
    }
    
    func applyDesign() {
        commentsTitle.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        commentsTitle.textColor = Color.lightText.value
    }

}
