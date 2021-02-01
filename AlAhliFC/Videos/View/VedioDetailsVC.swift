//
//  VedioDetailsVC.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/1/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class VedioDetailsVC: ParentViewController, UITableViewDelegate, UITableViewDataSource, reloadTVData {
    func updateData() {
        getVideoDetails()
    }
    
    @IBOutlet weak var vedioDetailsTV: UITableView!
    
    var link:String!
    let presenter = VideosPresenter()
    var video = Videos()
    var comments = [Comments]()
    
    var numberOfRows = 0
    var cPresenter = CommentPresneter()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "التفاصيل"
        vedioDetailsTV.delegate = self
        vedioDetailsTV.dataSource = self
        
        if isNetworkReachable {
            getVideoDetails()
        }else{
            self.showAlert(title: "أنت غير متصل الإنترنت", message: "", shouldpop: false)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            tableView.rowHeight = 250
            let cell = tableView.dequeueReusableCell(withIdentifier: "VedioCell", for: indexPath) as! VedioCell
            cell.configCell(video: video)
            return cell
        }else if indexPath.row == 1 {
            if (video.content?.isEmpty)! {
                tableView.rowHeight = 0
            }else{
                tableView.rowHeight = getTextViewHeight(text: video.content ?? "") + 80
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "VedioDetailsCell", for: indexPath) as! VedioDetailsCell
            cell.configCell(video: video)
            return cell
        }else if indexPath.row == 2 {
            tableView.rowHeight = 50
            let cell = tableView.dequeueReusableCell(withIdentifier: "VedioCommentsHeaderCell", for: indexPath) as! VedioCommentsHeaderCell
            cell.configCell()
            return cell
        }else {
            tableView.rowHeight = getTextViewHeight(text: "هذا النص ممكن ان يستبدل") + 80
            let cell = tableView.dequeueReusableCell(withIdentifier: "VedioCommentsCell", for: indexPath) as! VedioCommentsCell
            cell.configCell()
            cell.userComment.text = self.comments[indexPath.row - 3].content
            cell.userName.text = self.comments[indexPath.row - 3].parent_user_name
            return cell
        }
    }
    
    func getVideoDetails(){
        self.showLoader()
        presenter.getVideoDetails(videosLink: link, onSuccess: { (videoDetails) in
            self.video = videoDetails
            self.cPresenter.getComments(link: self.video.link!, onSuccess: { (comments) in
                self.comments = comments
                self.numberOfRows = self.comments.count + 3
                self.hideLoader()
                self.vedioDetailsTV.reloadData()

            }) { (errorMessage) in
                self.hideLoader()
                self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
            }
                self.hideLoader()

        }) { (errorMessage) in
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
        
    }
    
    @IBAction func toAddComment(_ sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Vedios", bundle: nil)
        let addCommentVC = storyboard.instantiateViewController(withIdentifier: "AddCommentVC") as! AddCommentVC
        addCommentVC.modalPresentationStyle = .overCurrentContext
        addCommentVC.modalTransitionStyle = .crossDissolve
        addCommentVC.link = self.video.link ?? ""
        addCommentVC.delegate = self
        self.navigationController?.pushViewController(addCommentVC, animated: true)    }
    
}
