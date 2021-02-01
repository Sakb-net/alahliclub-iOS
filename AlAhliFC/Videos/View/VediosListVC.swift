//
//  VediosListVC.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 6/30/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class VediosListVC: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var vediosListTV: UITableView!
    
    let presenter = VideosPresenter()
    var videos = [Videos]()
    
    var currentPageNumber = 0
    var canLoadMoreData = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "الفيديوهات"
        
        vediosListTV.delegate = self
        vediosListTV.dataSource = self
        vediosListTV.addSubview(self.refreshControl)
        
        if isNetworkReachable {
            getVideos()
        }else{
            self.showAlert(title: "أنت غير متصل الإنترنت", message: "", shouldpop: false)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 200
        let cell = tableView.dequeueReusableCell(withIdentifier: "VediesListCell", for: indexPath) as! VediesListCell
        
        cell.configCell(video: videos[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toVedioDetails", sender: indexPath.row)
    }
   
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let lastItem = videos.count - 1
        if indexPath.row == lastItem && canLoadMoreData
        {
            currentPageNumber += 1
            getVideos()
        }
    }


    func getVideos(){
        self.showLoader()
        presenter.getVideos(numPage: currentPageNumber, onSuccess: { (videos) in
            if videos.isEmpty {
                self.canLoadMoreData = false
            }
            self.videos += videos
            self.vediosListTV.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        getVideos()
        refreshControl.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toVedioDetails" {
            let index = sender as! Int
            let destination = segue.destination as! VedioDetailsVC
            destination.link = videos[index].link ?? ""
        }
    }
}
