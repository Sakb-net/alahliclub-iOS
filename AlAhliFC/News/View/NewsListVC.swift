//
//  NewsListVC.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/10/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class NewsListVC: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var newsListTV: UITableView!
    
    let presenter = NewsPresenter()
    var newsList = [News]()

    var currentPageNumber = 0
    var canLoadMoreData = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        menuBtn.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        
        menuBtn.addTarget(self, action: #selector(self.openSideMenu), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuBtn)
        
        self.navigationItem.title = "الأخبار"
        
        newsListTV.delegate = self
        newsListTV.dataSource = self
        newsListTV.addSubview(self.refreshControl)
        
        if isNetworkReachable {
            getNews()
        }else{
            self.showAlert(title: "أنت غير متصل الإنترنت", message: "", shouldpop: false)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 200
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListCell", for: indexPath) as! NewsListCell
        
        cell.configCell(news: newsList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toNewsDetails", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let lastItem = newsList.count - 1
        if indexPath.row == lastItem && canLoadMoreData
        {
            currentPageNumber += 1
            getNews()
        }
    }
    
    
    func getNews(){
        self.showLoader()
        presenter.getNews(numPage: currentPageNumber, onSuccess: { (news) in
            if news.isEmpty {
                self.canLoadMoreData = false
            }
            self.newsList += news
            self.newsListTV.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        getNews()
        refreshControl.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewsDetails" {
            let index = sender as! Int
            let destination = segue.destination as! NewsDetailsVC
            destination.link = newsList[index].link ?? ""
        }
    }
    
    //Side Menu
    @objc func openSideMenu(_ sender: UIButton) {
        performSegue(withIdentifier: "openMenu", sender: nil)
    }

}
