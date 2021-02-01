//
//  ImagesListVC.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/1/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class ImagesListVC: ParentViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var imagesListTV: UITableView!
    var albums = [Albums]()
    let presenter = AlbumsPresenter()
    
    var currentPageNumber = 0
    var canLoadMoreData = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "ألبوم الصور"
        
        imagesListTV.delegate = self
        imagesListTV.dataSource = self
        imagesListTV.addSubview(self.refreshControl)
        if isNetworkReachable {
            getAlbums()
        }else{
            self.showAlert(title: "أنت غير متصل الإنترنت", message: "", shouldpop: false)
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 200
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImagesListCell", for: indexPath) as! ImagesListCell
        cell.configCell(album: albums[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toAlbum", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let lastItem = albums.count - 1
        if indexPath.row == lastItem && canLoadMoreData
        {
            currentPageNumber += 1
            getAlbums()
        }
    }

    func getAlbums(){
        self.showLoader()
        presenter.getAlbums(numPage: currentPageNumber, onSuccess: { (albums) in
            if albums.isEmpty {
                self.canLoadMoreData = false
            }
            self.albums += albums
            self.imagesListTV.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        getAlbums()
        refreshControl.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlbum" {
            let index = sender as! Int
            let destination = segue.destination as! AlbumImagesVC
            destination.link = albums[index].link ?? ""
        }
    }
}
