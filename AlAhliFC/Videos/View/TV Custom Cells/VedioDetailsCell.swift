//
//  VedioDetailsCell.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/1/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class VedioDetailsCell: UITableViewCell {

    @IBOutlet weak var vedioDetails: UILabel!
    
    func configCell(video:Videos){
        applyDesign()
        vedioDetails.text = video.content
    }
    
    func applyDesign(){
        vedioDetails.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        vedioDetails.textColor = Color.lightText.value
    }

}
