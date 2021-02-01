//
//  VediesListCell.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 6/30/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SDWebImage

class VediesListCell: UITableViewCell {
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var vedioTitle: UILabel!
    @IBOutlet weak var vedioDate: UILabel!
    
    func configCell(video:Videos) {
        applyDesign()
        bgImage.sd_setImage(with: URL(string: Urls.baseUrl + (video.image ?? "")), placeholderImage: UIImage(named: "main_bg"))
        vedioTitle.text = video.name
        vedioDate.text = video.date
    }
    
    func applyDesign(){
        bgImage.layer.cornerRadius = 10
        bgImage.clipsToBounds = true
        vedioTitle.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().smallFontSize)
        vedioDate.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().smallFontSize)
        vedioDate.textColor = Color.lightText.value
    }
    
}
