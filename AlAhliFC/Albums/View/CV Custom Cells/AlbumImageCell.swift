//
//  AlbumImageCell.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/1/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class AlbumImageCell: UICollectionViewCell {
    
    @IBOutlet weak var albumImage: UIImageView!
    
    func configCell(images: Albums){
        albumImage.layer.cornerRadius = 10
        albumImage.clipsToBounds = true
        albumImage.sd_setImage(with: URL(string: Urls.baseUrl + (images.image ?? "")), placeholderImage: UIImage(named: "main_bg"))
    }
}
