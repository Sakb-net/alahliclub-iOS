//
//  NewsVedioesImageCell.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 6/30/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class NewsVedioesImageCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var newsVedioesImageCV: UICollectionView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    
    var selectedType = "news"
    var data:Any!
    
    func configCell(data: Any, type:String){
        newsVedioesImageCV.delegate = self
        newsVedioesImageCV.dataSource = self
        selectedType = type
        applyDesign()
        if type == "news" {
            cellTitle.text = "أحدث الأخبار"
             moreBtn.tag = 0
        }else if type == "vedios" {
            cellTitle.text = "أحدث الفيديوهات"
            moreBtn.tag = 1
        }else{
            cellTitle.text = "أحدث الصور"
            moreBtn.tag = 2
        }
        self.data = data
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedType == "news" {
            let news = data as! [News]
            return news.count
        }else if selectedType == "vedios" {
            let videos = data as! [Videos]
            return videos.count
        }else{
            let albums = data as! [Albums]
            return albums.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsVedioesImageCVCell", for: indexPath) as! NewsVedioesImageCVCell
        if selectedType == "news" {
            let news = data as! [News]
            cell.configCell(data: news[indexPath.row], type: selectedType, tag: indexPath.row)
        }else if selectedType == "vedios" {
            let videos = data as! [Videos]
             cell.configCell(data: videos[indexPath.row], type: selectedType, tag: indexPath.row)
        }else{
            let albums = data as! [Albums]
             cell.configCell(data: albums[indexPath.row], type: selectedType, tag: indexPath.row)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: screenWidth * 0.75, height: 150)
    }
    
    func applyDesign(){
        cellTitle.font = UIFont(name: AppFont().appFontBold, size: FontSizes().normalFontSize)
        cellTitle.textColor = Color.theme.value
        moreBtn.setTitleColor(Color.lightText.value, for: .normal)
        moreBtn.titleLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
    }
    
}
