//
//  PreviousAndNextMatchCell.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 6/30/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class PreviousAndNextMatchCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var previousNextMatchCV: UICollectionView!
    var nextMatch:NextMatch!
    var previousMatch:PresviousMatch!
    
    func configCell(nextMatch:NextMatch, previousMatch:PresviousMatch){
        previousNextMatchCV.delegate = self
        previousNextMatchCV.dataSource = self
        
        self.nextMatch = nextMatch
        self.previousMatch = previousMatch
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NextMatchCell", for: indexPath) as! NextMatchCell
            cell.configCell(nextMatch: nextMatch)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PreviousMatchCell", for: indexPath) as! PreviousMatchCell
            cell.configCell(previousMatch: previousMatch)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: screenWidth, height: 180)
        
       // return CGSize(width: StringHelper(text: newsCategoriesList[indexPath.row].title).getTextWidth(font: appFont.appFont, size: sizes.normalFontSize), height: sizes.navBarHeight)
    }
}
