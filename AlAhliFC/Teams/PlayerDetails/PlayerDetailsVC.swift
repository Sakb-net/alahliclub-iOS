//
//  PlayerDetailsVC.swift
//  AlAhliFC
//
//  Created by Basma on 9/13/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class PlayerDetailsVC: ParentViewController, passPlayerDetails {
    func passPlayer(player: Players) {
        self.player = player
    }
    

    @IBOutlet weak var playerPhoto: UIImageView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var waightLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var sportLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var spotLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    var player = Players()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.player)
        self.detailsView.layer.cornerRadius = 10
        self.detailsView.clipsToBounds = true
        self.playerPhoto.sd_setImage(with: URL(string: Urls.baseUrl + (self.player.user_image ?? "")), placeholderImage: UIImage(named: "main_bg"))
        self.nameLabel.text = self.player.name
        self.numLabel.text = self.player.num_sport
        self.waightLabel.text = self.player.weight
        self.ageLabel.text = self.player.age
        self.birthDateLabel.text = self.player.birthdate
        self.sportLabel.text = self.player.sport
        self.heightLabel.text = self.player.height
        self.sportLabel.text = self.player.location
        self.nationalityLabel.text = self.player.national
        addShadow ()
    }
    
    func addShadow (){
        self.detailsView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.175).cgColor
        self.detailsView.layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        self.detailsView.layer.shadowOpacity = 1.0
        self.detailsView.layer.shadowRadius = 4.0
        self.detailsView.layer.masksToBounds = false
    }
}
