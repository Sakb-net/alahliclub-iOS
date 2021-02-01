//
//  TeamsVC.swift
//  AlAhliFC
//
//  Created by Basma on 9/5/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class TeamsVC: ParentViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    @IBOutlet weak var collectionView: UICollectionView!
    var presenter = TeamsPresenter()
    var teams = [TeamsDetails]()
    var index = 0
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.teams.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as! TeamCell
        cell.teamLabel.text = self.teams[indexPath.row].name
        presenter.roundedView(view: cell.cellBg)
        
        return cell
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.index = indexPath.row
        performSegue(withIdentifier: "openPlayersVC", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "الفرق"
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        menuBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        menuBtn.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        menuBtn.addTarget(self, action: #selector(self.openSideMenu), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuBtn)
    
        presenter.getTeamsDetails(onSuccess: { (teams) in
            self.teams = teams
            self.collectionView.reloadData()
            print(teams)
    }) { (errorMessage) in
    }
    }
    
    @objc func openSideMenu(_ sender: UIButton) {
        performSegue(withIdentifier: "openMenu", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openPlayersVC" {
            if let destinationVC = segue.destination as? PlayersVC {
                destinationVC.team = self.teams[index]
            }
        }
    }
}
