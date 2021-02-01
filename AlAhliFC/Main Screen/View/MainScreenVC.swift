//
//  ViewController.swift
//  StarterProject
//
//  Created by Mohammed Saleh on 2/2/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import Reachability


class MainScreenVC: ParentViewController, UITableViewDelegate, UITableViewDataSource, MoreButtonsDelegate {
    func showMore() {
        let vedioDetailsVC = Storyboard().productsStoryboard.instantiateViewController(withIdentifier: "ProductsCategoriesVC") as! ProductsCategoriesVC
        self.navigationController?.pushViewController(vedioDetailsVC, animated: true)
    }
    

    @IBOutlet weak var mainScreenTV: UITableView!
    
    let presenter = MainScreenPresenter()
    
    var ticketLink:String!
    var nextMatch:NextMatch!
    var presviousMatch:PresviousMatch!
    var news = [News]()
    var videos = [Videos]()
    var albums = [Albums]()
    var products = [Products]()
    
    var numbersOfRows = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(User.shared().access_token)
        
        self.navigationItem.title = "الرئيسية"
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.checkInternetStatus(notification:)), name: Notification.Name("notifyIntetnetStatus"), object: nil)
        
        mainScreenTV.delegate = self
        mainScreenTV.dataSource = self
        mainScreenTV.addSubview(self.refreshControl)
        
        menuBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        menuBtn.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        
        menuBtn.addTarget(self, action: #selector(self.openSideMenu), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuBtn)
        
        menuBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        menuBtn.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.setImage(#imageLiteral(resourceName: "store"), for: .normal)
        
        menuBtn.addTarget(self, action: #selector(self.openProductsStore), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuBtn)
        
        
        if isNetworkReachable {
            getMainScreenInfo()
        }else{
             self.showAlert(title: "أنت غير متصل الإنترنت", message: "", shouldpop: false)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbersOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            tableView.rowHeight = 180
            let cell = tableView.dequeueReusableCell(withIdentifier: "PreviousAndNextMatchCell", for: indexPath) as! PreviousAndNextMatchCell
            cell.configCell(nextMatch: nextMatch, previousMatch: presviousMatch)
            return cell
        }else if indexPath.row == 1 {
            tableView.rowHeight = 200
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsVedioesImageCell", for: indexPath) as! NewsVedioesImageCell
            cell.configCell(data: news, type: "news")
            return cell
        }else if indexPath.row == 2 {
            tableView.rowHeight = 200
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsVedioesImageCell", for: indexPath) as! NewsVedioesImageCell
            cell.configCell(data: videos, type: "vedios")
            return cell
        }else if indexPath.row == 3 {
            tableView.rowHeight = 200
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsVedioesImageCell", for: indexPath) as! NewsVedioesImageCell
            cell.configCell(data: albums, type: "images")
            return cell
        }else{
            tableView.rowHeight = 280
            let cell = tableView.dequeueReusableCell(withIdentifier: "LatestProductsCell", for: indexPath) as! LatestProductsCell
            cell.delegate = self
            cell.configCell(products: products)
            return cell
        }
    }
    
    func getMainScreenInfo(){
        self.showLoader()
        presenter.getHomeDetails(onSuccess: { (ticketLink, nextMatch, presviousMatch, news, videos, albums, products) in
            self.ticketLink = ticketLink
            self.nextMatch = nextMatch
            self.presviousMatch = presviousMatch
            self.news = news
            self.albums = albums
            self.videos = videos
            self.products = products
            self.numbersOfRows = 5
            self.mainScreenTV.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    @IBAction func openMoreScreen(_ sender: UIButton) {
        if sender.tag == 0 {
            let newsListVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "NewsListVC") as! NewsListVC
            self.navigationController?.pushViewController(newsListVC, animated: true)
        }else if sender.tag == 1 {
            let vediosListVC = Storyboard().vediosStoryboard.instantiateViewController(withIdentifier: "VediosListVC") as! VediosListVC
            self.navigationController?.pushViewController(vediosListVC, animated: true)
        }else if sender.tag == 2 {
            let imagesListVC = Storyboard().imagesStoryboard.instantiateViewController(withIdentifier: "ImagesListVC") as! ImagesListVC
            self.navigationController?.pushViewController(imagesListVC, animated: true)
        }
    }
    
    
    @objc func openProductsStore(_ sender: UIButton) {
        let vedioDetailsVC = Storyboard().productsStoryboard.instantiateViewController(withIdentifier: "ProductsCategoriesVC") as! ProductsCategoriesVC
        self.navigationController?.pushViewController(vedioDetailsVC, animated: true)
    }
    
    @IBAction func openNewsDetails(_ sender: UIButton) {
        let newsDetailsVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "NewsDetailsVC") as! NewsDetailsVC
        newsDetailsVC.link = news[sender.tag].link ?? ""
        self.navigationController?.pushViewController(newsDetailsVC, animated: true)
    }
    
    @IBAction func openTicketingScreen(_ sender: Any) {
        if let url = URL(string: "http://alahliclub.sakb.net/matches/next"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func openVedioDetails(_ sender: UIButton) {
        let vedioDetailsVC = Storyboard().vediosStoryboard.instantiateViewController(withIdentifier: "VedioDetailsVC") as! VedioDetailsVC
        vedioDetailsVC.link = videos[sender.tag].link ?? ""
        self.navigationController?.pushViewController(vedioDetailsVC, animated: true)
    }
    
    @IBAction func openImageDetails(_ sender: UIButton) {
        let albumImagesVC = Storyboard().imagesStoryboard.instantiateViewController(withIdentifier: "AlbumImagesVC") as! AlbumImagesVC
        albumImagesVC.link = albums[sender.tag].link ?? ""
        self.navigationController?.pushViewController(albumImagesVC, animated: true)
    }
    //Side Menu
    @objc func openSideMenu(_ sender: UIButton) {
        performSegue(withIdentifier: "openMenu", sender: nil)
    }
    
    @objc func checkInternetStatus(notification: Notification) {
        let isConeected = notification.object as? Bool ?? false
        if isConeected {
           getMainScreenInfo()
        }else{
            self.showAlert(title: "أنت غير متصل الإنترنت", message: "", shouldpop: false)
        }
    }

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        getMainScreenInfo()
        refreshControl.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTicketingScreen" {
            let destination = segue.destination as! TicketingVC
            destination.ticketingUrl = ticketLink
        }
    }
}


