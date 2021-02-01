//
//  NewsDetailsVC.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/10/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class NewsDetailsVC: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var newsDetailsTV: UITableView!
    var numberofRows = 0
    let presenter = NewsPresenter()
    var news = News()
    var link:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "التفاصيل"
        newsDetailsTV.delegate = self
        newsDetailsTV.dataSource = self
        
        if isNetworkReachable {
            getNewsDetails()
        }else{
            self.showAlert(title: "أنت غير متصل الإنترنت", message: "", shouldpop: false)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberofRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            tableView.rowHeight = 255
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsImageCell", for: indexPath) as! NewsImageCell
            cell.configCell(news: news)
            return cell
        }else{
            tableView.rowHeight = getTextViewHeight(text: news.desc ?? "") + 200
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsContentCell", for: indexPath) as! NewsContentCell
            cell.configCell(news: news)
            return cell
        }
    }
    
    func getNewsDetails(){
        self.showLoader()
        presenter.getNewsDetails(newsLink: link, onSuccess: { (news) in
            self.news = news
            self.numberofRows = 2
            self.newsDetailsTV.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
}
