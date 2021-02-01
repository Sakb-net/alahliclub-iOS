//
//  NewsVedioesImageCVCell.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 6/30/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SDWebImage

class NewsVedioesImageCVCell: UICollectionViewCell {
    
    @IBOutlet weak var newsDetailsContainer: UIView!
    @IBOutlet weak var vediosDetailsContainer: UIView!
    @IBOutlet weak var imagesDetailsContainer: UIView!
    @IBOutlet weak var newsBtn: UIButton!
    @IBOutlet weak var vediosBtn: UIButton!
    @IBOutlet weak var imagesBtn: UIButton!
    
    @IBOutlet weak var bgImage: UIImageView!
    
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    
    @IBOutlet weak var vedioTitle: UILabel!
    
    @IBOutlet weak var imageTitle: UILabel!
    
    var selectedType = "news"
    
    func configCell(data:Any, type:String, tag:Int) {
        selectedType = type
        applyDesgin()
        
        if type == "news" {
            newsDetailsContainer.isHidden = false
            vediosDetailsContainer.isHidden = true
            imagesDetailsContainer.isHidden = true
            
            newsBtn.isHidden = false
            vediosBtn.isHidden = true
            imagesBtn.isHidden = true
            
            let news = data as! News
            bgImage.sd_setImage(with: URL(string: Urls.baseUrl + (news.image ?? "")), placeholderImage: UIImage(named: "main_bg"))
            newsTitle.text = news.name
            newsDate.text = news.date
            newsBtn.tag = tag
            
        }else if type == "vedios" {
            vediosDetailsContainer.isHidden = false
            newsDetailsContainer.isHidden = true
            imagesDetailsContainer.isHidden = true
            
            vediosBtn.isHidden = false
            newsBtn.isHidden = true
            imagesBtn.isHidden = true
            
            let video = data as! Videos
            bgImage.sd_setImage(with: URL(string: Urls.baseUrl + (video.image ?? "")), placeholderImage: UIImage(named: "main_bg"))
            vedioTitle.text = video.name
            vediosBtn.tag = tag
            
        }else if type == "images" {
            imagesDetailsContainer.isHidden = false
            newsDetailsContainer.isHidden = true
            vediosDetailsContainer.isHidden = true
            
            imagesBtn.isHidden = false
            vediosBtn.isHidden = true
            newsBtn.isHidden = true
            
            let album = data as! Albums
            bgImage.sd_setImage(with: URL(string: Urls.baseUrl + (album.image ?? "")), placeholderImage: UIImage(named: "main_bg"))
            imageTitle.text = album.name
            imagesBtn.tag = tag
        }
        
    }
    
    func applyDesgin() {
        newsDetailsContainer.layer.cornerRadius = 10
        vediosDetailsContainer.layer.cornerRadius = 10
        imagesDetailsContainer.layer.cornerRadius = 10
        bgImage.layer.cornerRadius = 10
        bgImage.clipsToBounds = true
        
        if selectedType == "news" {
            newsTitle.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().smallFontSize)
            newsDate.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().smallFontSize)
            newsDate.textColor = Color.lightText.value
        }else if selectedType == "vedios" {
            vedioTitle.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().smallFontSize)
        }else if selectedType == "images" {
            imageTitle.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().smallFontSize)
        }
       
        
    }
}
