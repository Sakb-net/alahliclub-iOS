//
//  PreviousMatchesCell.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/11/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class PreviousMatchesCell: UITableViewCell {

    @IBOutlet weak var matchDate: UILabel!
    @IBOutlet weak var matchTime: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var leftSideTeamLogo: UIImageView!
    @IBOutlet weak var leftSideTeamName: UILabel!
    @IBOutlet weak var rightSideTeamLogo: UIImageView! //firts team
    @IBOutlet weak var rightSideTeamName: UILabel! //firts team
    @IBOutlet weak var detailsTitle: UILabel!
    
    
    func configCell(prevMatch:PresviousMatch) {
        applyDesign()
        
        rightSideTeamName.text = prevMatch.first_team
        rightSideTeamLogo.sd_setImage(with: URL(string: Urls.baseUrl + (prevMatch.first_image ?? "")), placeholderImage: UIImage(named: "placeholder"))
        
        leftSideTeamName.text = prevMatch.second_team
        leftSideTeamLogo.sd_setImage(with: URL(string: Urls.baseUrl + (prevMatch.second_image ?? "")), placeholderImage: UIImage(named: "placeholder"))
        
        matchDate.text = prevMatch.date
        matchTime.text = prevMatch.time
        score.text = String(prevMatch.second_goal ?? 0) + " - " + String(prevMatch.first_goal ?? 0)
    }
    
    func applyDesign() {
        
        matchDate.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        matchDate.textColor = Color.theme.value
        
        matchTime.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        matchTime.textColor = Color.lightText.value
        
        score.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        score.textColor = Color.darkText.value
        
        leftSideTeamName.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        leftSideTeamName.textColor = Color.darkText.value
        
        rightSideTeamName.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        rightSideTeamName.textColor = Color.darkText.value
        
        detailsTitle.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        detailsTitle.textColor = Color.darkText.value
    }

}
