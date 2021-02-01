//
//  NewsContentCell.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/10/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class NewsContentCell: UITableViewCell {

    @IBOutlet weak var newsContent: UILabel!
    
    func configCell(news:News) {
        newsContent.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        newsContent.textColor = Color.lightText.value
        
        newsContent.text = news.desc
    }
}
