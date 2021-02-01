//
//  ChampionshipsVC.swift
//  AlAhliFC
//
//  Created by Basma on 9/3/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class ChampionshipsVC: ParentViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var championshipsPresenter = ChampionshipPrestenter()
    var champsList = [Championships]()
    var teamsList = [Teams]()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.champsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "ChampCell", for: indexPath) as! ChampCell
        cell.champTitle.text = self.champsList[indexPath.row].name
        cell.champIV.sd_setImage(with: URL(string: Urls.baseUrl + (self.champsList[indexPath.row].icon_image ?? "")), placeholderImage: UIImage(named: "main_bg"))
        roundedView(view: cell.cellBgV)

        return cell
    }
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func searchAction(_ sender: Any) {
    }
    @IBAction func menuAction(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.navigationItem.title = "البطولات"

        
        menuBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        menuBtn.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        
        menuBtn.addTarget(self, action: #selector(self.openSideMenu), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuBtn)
        
        menuBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        menuBtn.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.setImage(#imageLiteral(resourceName: "search"), for: .normal)
        
        menuBtn.addTarget(self, action: #selector(self.openSearchVC), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuBtn)
        
        championshipsPresenter.getChamps(onSuccess: { (champs, cTeams) in
            if cTeams.isEmpty {
            }
            self.champsList += champs
            self.teamsList += cTeams
            self.collectionView.reloadData()
//            if teams.isEmpty {
//                self.canLoadMoreData = false
//            }
//            self.teamsList += teams
//            self.newsListTV.reloadData()
//            self.hideLoader()
        }) { (errorMessage) in
//            self.hideLoader()
//            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    @objc func openSideMenu(_ sender: UIButton) {
        performSegue(withIdentifier: "openMenu", sender: nil)
    }
    @objc func openSearchVC(_ sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popupVC = storyboard.instantiateViewController(withIdentifier: "ChampsSearchVC") as! ChampsSearchVC
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.teamList = self.teamsList
        
        present(popupVC, animated: true, completion: nil)

//        performSegue(withIdentifier: "openSearchVC", sender: nil)
    }
    func roundedView(view : UIView){
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        
    }
    }
