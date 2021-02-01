//
//  ImagesListCell.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/1/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class ImagesListCell: UITableViewCell {

    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var imagesTitle: UILabel!
    @IBOutlet weak var imageDate: UILabel!
    
    func configCell(album:Albums) {
        applyDesign()
        bgImage.sd_setImage(with: URL(string: Urls.baseUrl + (album.image ?? "")), placeholderImage: UIImage(named: "main_bg"))
        imagesTitle.text = album.name
        imageDate.text = album.date
    }
    
    func applyDesign(){
        bgImage.layer.cornerRadius = 10
        bgImage.clipsToBounds = true
        imagesTitle.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().smallFontSize)
        imageDate.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().smallFontSize)
        imageDate.textColor = Color.lightText.value
    }

}
