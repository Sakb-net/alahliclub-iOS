//
//  PlayersVC.swift
//  AlAhliFC
//
//  Created by Basma on 9/8/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class PlayersVC: ParentViewController, UICollectionViewDelegate, UICollectionViewDataSource, SelectedDropDownType {
    
    @IBOutlet weak var subTeamsTF: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var playerBT: UIButton!
    @IBOutlet weak var playerV: UIView!
    @IBOutlet weak var coachesBT: UIButton!
    @IBOutlet var coachesV: UIView!
    @IBOutlet weak var btsView: UIView!
    var team = TeamsDetails()
    var presenter = TeamsPresenter()
    var sTeam = SubTeams()
    var players = [Players]()
    var coaches = [Players]()
    var selectedBT = 0
    
    @IBAction func PlayersAction(_ sender: Any) {
        self.playerV.isHidden = false
        self.coachesV.isHidden = true
        self.selectedBT = 0
        self.players.removeAll()
        getPlayers()
        self.collectionView.reloadData()
    }
    @IBAction func CoachesAvtion(_ sender: Any) {
        self.playerV.isHidden = true
        self.coachesV.isHidden = false
        self.selectedBT = 1
        self.coaches.removeAll()
        getPlayers()
        self.collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedBT == 0 {
            return self.players.count
        }else {
            return self.coaches.count
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if selectedBT == 0 {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
        cell.playerName.text = self.players[indexPath.row].name
        cell.playerPosition.text = self.players[indexPath.row].location
        cell.playerIV.sd_setImage(with: URL(string: Urls.baseUrl + (self.players[indexPath.row].user_image ?? "")), placeholderImage: UIImage(named: "main_bg"))
            return cell
        }else {
        let cell1 = collectionView
            .dequeueReusableCell(withReuseIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
        cell1.playerName.text = self.coaches[indexPath.row].name
        cell1.playerPosition.text = self.coaches[indexPath.row].location
        cell1.playerIV.sd_setImage(with: URL(string: Urls.baseUrl + (self.coaches[indexPath.row].user_image ?? "")), placeholderImage: UIImage(named: "main_bg"))
        return cell1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let playerDetailsVC = storyboard.instantiateViewController(withIdentifier: "PlayerDetailsVC") as! PlayerDetailsVC
        playerDetailsVC.modalPresentationStyle = .overCurrentContext
        playerDetailsVC.modalTransitionStyle = .crossDissolve
        if selectedBT == 0{
            playerDetailsVC.player = self.players[indexPath.row]
        }else {
            playerDetailsVC.player = self.coaches[indexPath.row]
        }
        self.navigationController?.pushViewController(playerDetailsVC, animated: true)
    }
    
    func selectedType(selectedType: DropDownTypes, selectedItem: Any) {
        self.sTeam = selectedItem as! SubTeams
        self.playerBT.isEnabled = true
        self.coachesBT.isEnabled = true
        self.btsView.isHidden = false
        getPlayers()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.team.name
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        menuBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        menuBtn.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        menuBtn.addTarget(self, action: #selector(self.openSideMenu), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuBtn)
        
        leftTFImage ()
        

    }
    @objc func openSideMenu(_ sender: UIButton) {
        performSegue(withIdentifier: "openMenu", sender: nil)
    }
    
    func leftTFImage (){
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "drop_down_arrow"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(self.subTeamsTF.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.showDropDown), for: .touchUpInside)
        self.subTeamsTF.leftView = button
        self.subTeamsTF.leftViewMode = .always
        
        self.subTeamsTF.layer.cornerRadius = 10
        self.subTeamsTF.clipsToBounds = true
        
        self.subTeamsTF.addTarget(self, action: #selector(self.showDropDown), for: .touchDown)

    }
    
    @objc func showDropDown(){
        let dropDownVC = Storyboard().dropDownStoryboard.instantiateViewController(withIdentifier: "DropDownVC") as! DropDownVC
        
        dropDownVC.selectDelegate = self
        dropDownVC.selectedType = .subTeams
        dropDownVC.supTeams = self.team.subTeams!
        present(dropDownVC, animated: true
            , completion: nil)
    }
    
    func getPlayers(){
        self.showLoader()
        presenter.getPlayers(team_link: self.sTeam.link!, onSuccess: { (players, coachs, name) in
            self.players = players
            self.coaches = coachs
            self.subTeamsTF.text = name
            self.collectionView.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
        }
    }
    
    
}
