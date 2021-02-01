//
//  PreviousMatchCell.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 6/30/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class PreviousMatchCell: UICollectionViewCell {
    @IBOutlet weak var previousMatchTitle: UILabel!
    @IBOutlet weak var matchScore: UILabel!
    @IBOutlet weak var leftSideTeamLogo: UIImageView!
    @IBOutlet weak var leftSideTeamName: UILabel!
    @IBOutlet weak var rightSideTeamLogo: UIImageView!//first team
    @IBOutlet weak var rightSideTeamName: UILabel!
    @IBOutlet weak var matchTime: UILabel!
    
    
    func configCell(previousMatch:PresviousMatch) {
        applyDesign()
        
        rightSideTeamName.text = previousMatch.first_team
        rightSideTeamLogo.sd_setImage(with: URL(string: Urls.baseUrl + (previousMatch.first_image ?? "")), placeholderImage: UIImage(named: "placeholder"))
        
        leftSideTeamName.text = previousMatch.second_team
        leftSideTeamLogo.sd_setImage(with: URL(string: Urls.baseUrl + (previousMatch.second_image ?? "")), placeholderImage: UIImage(named: "placeholder"))
        
        matchTime.text = (previousMatch.date ?? "") + ", " + (previousMatch.time ?? "")
        var matchScoreLabel = String((previousMatch.second_goal ?? 0))
        matchScoreLabel += " - "
        matchScoreLabel += String((previousMatch.first_goal ?? 0))
        matchScore.text =  matchScoreLabel
        
    }
    
    func applyDesign() {
        previousMatchTitle.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().largeFontSize)
        matchScore.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        leftSideTeamName.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        rightSideTeamName.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        matchTime.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().smallFontSize)
        matchTime.textColor = Color.yellowText.value
        
    }
}
