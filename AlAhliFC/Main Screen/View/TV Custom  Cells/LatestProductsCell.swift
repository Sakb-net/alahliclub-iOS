//
//  LatestProductsCell.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 6/30/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
protocol MoreButtonsDelegate{
    func showMore()
}
class LatestProductsCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var latestProductsCV: UICollectionView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    var products = [Products]()
    var delegate:MoreButtonsDelegate!

    @IBAction func showMore(_ sender: Any) {
        
        self.delegate?.showMore()
    }
    func configCell(products: [Products]){
        latestProductsCV.delegate = self
        latestProductsCV.dataSource = self
        applyDesign()
        self.products = products
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestProductsCVCell", for: indexPath) as! LatestProductsCVCell
        cell.configCell(product: products[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: screenWidth * 0.45, height: 220)
    }
    
    func applyDesign(){
        cellTitle.font = UIFont(name: AppFont().appFontBold, size: FontSizes().normalFontSize)
        cellTitle.textColor = Color.theme.value
        moreBtn.setTitleColor(Color.lightText.value, for: .normal)
        moreBtn.titleLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
    }
    
}
