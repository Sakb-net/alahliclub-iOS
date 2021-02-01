//
//  AlbumImagesVC.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/1/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class AlbumImagesVC: ParentViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var ablumImages: UICollectionView!
    @IBOutlet weak var albumTitle: UILabel!
    let presenter = AlbumsPresenter()
    
    var link:String!
    var albumData:Albums!
    var albumImages = [Albums]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "التفاصيل"
        applyDesign()
        ablumImages.delegate = self
        ablumImages.dataSource = self
        if isNetworkReachable {
            getAlbumImages()
        }else{
            self.showAlert(title: "أنت غير متصل الإنترنت", message: "", shouldpop: false)
        }
        
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumImageCell", for: indexPath) as! AlbumImageCell
        cell.configCell(images: albumImages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: screenWidth * 0.45, height: screenWidth * 0.6)
    }
    
    func getAlbumImages(){
        self.showLoader()
        presenter.getAlbumImages(albumsLink: link, onSuccess: { (albumData, albumImages) in
            self.albumData = albumData
            self.albumTitle.text = albumData.name
            self.albumImages = albumImages
            self.ablumImages.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func applyDesign(){
        albumTitle.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        albumTitle.textColor = Color.darkText.value
    }

}
