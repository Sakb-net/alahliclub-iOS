//
//  NextMatchCell.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 6/30/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SDWebImage

class NextMatchCell: UICollectionViewCell {
    @IBOutlet weak var nextMatchTitle: UILabel!
    @IBOutlet weak var vsTitle: UILabel!
    @IBOutlet weak var leftSideTeamLogo: UIImageView!
    @IBOutlet weak var leftSideTeamName: UILabel!
    @IBOutlet weak var rightSideTeamLogo: UIImageView! //firts team
    @IBOutlet weak var rightSideTeamName: UILabel! //firts team
    @IBOutlet weak var matchTime: UILabel!
    @IBOutlet weak var reserveYourTicket: UIButton!
    
    
    func configCell(nextMatch:NextMatch) {
        applyDesign()
        
        rightSideTeamName.text = nextMatch.first_team
        rightSideTeamLogo.sd_setImage(with: URL(string: Urls.baseUrl + (nextMatch.first_image ?? "")), placeholderImage: UIImage(named: "placeholder"))
        
        leftSideTeamName.text = nextMatch.second_team
        leftSideTeamLogo.sd_setImage(with: URL(string: Urls.baseUrl + (nextMatch.second_image ?? "")), placeholderImage: UIImage(named: "placeholder"))
        
        matchTime.text = (nextMatch.date ?? "") + ", " + (nextMatch.time ?? "")
    }
    
    func applyDesign() {
        nextMatchTitle.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().largeFontSize)
        vsTitle.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        leftSideTeamName.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        rightSideTeamName.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        matchTime.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().smallFontSize)
        matchTime.textColor = Color.yellowText.value
        
        reserveYourTicket.backgroundColor = Color.theme.value
        reserveYourTicket.setTitleColor(UIColor.white, for: .normal)
        reserveYourTicket.titleLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().smallFontSize)
        reserveYourTicket.layer.cornerRadius = 5
    }
}
