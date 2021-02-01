//
//  NewsListCell.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/10/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class NewsListCell: UITableViewCell {

    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    
    func configCell(news:News) {
        applyDesign()
        bgImage.sd_setImage(with: URL(string: Urls.baseUrl + (news.image ?? "")), placeholderImage: UIImage(named: "main_bg"))
        newsTitle.text = news.name
        newsDate.text = news.date
    }
    
    func applyDesign(){
        bgImage.layer.cornerRadius = 10
        bgImage.clipsToBounds = true
        newsTitle.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().smallFontSize)
        newsDate.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().smallFontSize)
        newsDate.textColor = Color.lightText.value
    }

}
