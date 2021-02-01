//
//  PlayersViewController.swift
//  AlAhliFC
//
//  Created by Basma on 9/16/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
protocol passPlayerDetails {
    func passPlayer(player : Players)
}
class PlayersViewController: UINavigationController {
    
    var player = Players()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(player)
        let passPlayer = PlayerDetailsVC()
        passPlayer.passPlayer(player: self.player)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let playerDetails = segue.destination as! PlayerDetailsVC
        playerDetails.player = self.player
        
    }
}
