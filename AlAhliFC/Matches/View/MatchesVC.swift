//
//  MatchesVC.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/10/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class MatchesVC: ParentViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var matchesTV: UITableView!
    @IBOutlet weak var nextMatches: UIButton!
    @IBOutlet weak var nextMatchesUnderLine: UIView!
    @IBOutlet weak var previousMatches: UIButton!
    @IBOutlet weak var previousMatchesUnderLine: UIView!
    
    var nextMatchesList = [NextMatch]()
    var previousMatchesList = [PresviousMatch]()
    
    var selectedType = "next" //prev
    
    let presenter = MatchesPresenter()
    
    var currentPageNumber = 0
    var canLoadMoreData = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "المباريات"
        applyDesign()
        
        matchesTV.delegate = self
        matchesTV.dataSource = self
        matchesTV.addSubview(self.refreshControl)
        
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
        
        menuBtn.addTarget(self, action: #selector(self.search), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuBtn)
        
        if isNetworkReachable {
            getNextMatches()
        }else{
            self.showAlert(title: "أنت غير متصل الإنترنت", message: "", shouldpop: false)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedType == "next" {
            return nextMatchesList.count
        }else{
            return previousMatchesList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if selectedType == "next" {
           tableView.rowHeight = 180
            let cell = tableView.dequeueReusableCell(withIdentifier: "NextMatchesCell", for: indexPath) as! NextMatchesCell
            cell.configCell(nextMatch: nextMatchesList[indexPath.row])
            return cell
        }else{
            tableView.rowHeight = 220
            let cell = tableView.dequeueReusableCell(withIdentifier: "PreviousMatchesCell", for: indexPath) as! PreviousMatchesCell
            cell.configCell(prevMatch: previousMatchesList[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
         if selectedType == "next" {
            let lastItem = nextMatchesList.count - 1
            if indexPath.row == lastItem && canLoadMoreData
            {
                currentPageNumber += 1
                getNextMatches()
            }
         }else{
            let lastItem = previousMatchesList.count - 1
            if indexPath.row == lastItem && canLoadMoreData
            {
                currentPageNumber += 1
                getPreviousMatches()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedType == "prev" {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let matchesResultsVC = storyboard.instantiateViewController(withIdentifier: "MatchesResultsVC") as! MatchesResultsVC
        matchesResultsVC.matchLink = self.previousMatchesList[indexPath.row].link
        self.navigationController?.pushViewController(matchesResultsVC, animated: true)
        }
    }

    @IBAction func nextMatches(_ sender: UIButton) {
        self.selectedType = "next"
        self.currentPageNumber = 0
        self.canLoadMoreData = true
        self.nextMatchesUnderLine.isHidden = false
        self.previousMatchesUnderLine.isHidden = true
        nextMatchesList.removeAll()
        matchesTV.reloadData()
        getNextMatches()
    }
    
    @IBAction func previousMatches(_ sender: UIButton) {
        self.selectedType = "prev"
        self.currentPageNumber = 0
        self.canLoadMoreData = true
        self.nextMatchesUnderLine.isHidden = true
        self.previousMatchesUnderLine.isHidden = false
        previousMatchesList.removeAll()
        matchesTV.reloadData()
        getPreviousMatches()
    }
    
    func getNextMatches(){
        self.showLoader()
        presenter.getNextMatches(numPage: currentPageNumber, onSuccess: { (nextMatches) in
            if nextMatches.isEmpty {
                self.canLoadMoreData = false
            }
            self.nextMatchesList += nextMatches
            self.matchesTV.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func getPreviousMatches(){
        self.showLoader()
        presenter.getPreviousMatches(numPage: currentPageNumber, onSuccess: { (prevMatches) in
            if prevMatches.isEmpty {
                self.canLoadMoreData = false
            }
            self.previousMatchesList += prevMatches
            self.matchesTV.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func applyDesign(){
        nextMatches.setTitleColor(Color.darkText.value, for: .normal)
        nextMatches.titleLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        
        previousMatches.setTitleColor(Color.darkText.value, for: .normal)
        previousMatches.titleLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        if selectedType == "next" {
            getNextMatches()
        }else{
            getPreviousMatches()
        }
        refreshControl.endRefreshing()
    }
    
    @objc func openSideMenu(_ sender: UIButton) {
        performSegue(withIdentifier: "openMenu", sender: nil)
    }
    
    @objc func search(_ sender: UIButton) {
        performSegue(withIdentifier: "openMenu", sender: nil)
    }
}
