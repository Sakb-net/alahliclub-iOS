//
//  NextMatchesCell.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/11/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class NextMatchesCell: UITableViewCell {

    @IBOutlet weak var matchDate: UILabel!
    @IBOutlet weak var matchTime: UILabel!
    @IBOutlet weak var vsTitle: UILabel!
    @IBOutlet weak var leftSideTeamLogo: UIImageView!
    @IBOutlet weak var leftSideTeamName: UILabel!
    @IBOutlet weak var rightSideTeamLogo: UIImageView! //firts team
    @IBOutlet weak var rightSideTeamName: UILabel! //firts team
    
    
    func configCell(nextMatch:NextMatch) {
        applyDesign()
        
        rightSideTeamName.text = nextMatch.first_team
        rightSideTeamLogo.sd_setImage(with: URL(string: Urls.baseUrl + (nextMatch.first_image ?? "")), placeholderImage: UIImage(named: "placeholder"))
        
        leftSideTeamName.text = nextMatch.second_team
        leftSideTeamLogo.sd_setImage(with: URL(string: Urls.baseUrl + (nextMatch.second_image ?? "")), placeholderImage: UIImage(named: "placeholder"))
        
        matchDate.text = nextMatch.date
        matchTime.text = nextMatch.time
    }
    
    func applyDesign() {
        
        matchDate.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        matchDate.textColor = Color.theme.value
        
        matchTime.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        matchTime.textColor = Color.lightText.value
       
        vsTitle.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        vsTitle.textColor = Color.darkText.value
        
        leftSideTeamName.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        leftSideTeamName.textColor = Color.darkText.value
        
        rightSideTeamName.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        rightSideTeamName.textColor = Color.darkText.value
        
    }

}
