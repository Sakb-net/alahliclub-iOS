//
//  MatchesResultsVC.swift
//  AlAhliFC
//
//  Created by Basma on 9/21/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

class MatchesResultsVC: ParentViewController{
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var firstLogoIV: UIImageView!
    @IBOutlet weak var secondLogoIV: UIImageView!
    @IBOutlet weak var firstClubName: UILabel!
    @IBOutlet weak var secondClubName: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var firstGoalsTV: UITableView!
    @IBOutlet weak var secondGoalsTV: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var videoBT: UIButton!
    @IBOutlet weak var statisticsBT: UIButton!
    @IBOutlet weak var descriptionBT: UIButton!
    @IBOutlet weak var videoPlayer: WKYTPlayerView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var descSelectView: UIView!
    @IBOutlet weak var statesSelectedView: UIView!
    @IBOutlet weak var videoSelectedView: UIView!
    @IBOutlet weak var sFirstClub: UILabel!
    @IBOutlet weak var sSecondClub: UILabel!
    @IBOutlet weak var sFirstGoals: UILabel!
    @IBOutlet weak var sSecondGoals: UILabel!
    @IBOutlet weak var sFirstCorners: UILabel!
    @IBOutlet weak var sSecondCorners: UILabel!
    @IBOutlet weak var sFirstOffSide: UILabel!
    @IBOutlet weak var sSecondOffSide: UILabel!
    @IBOutlet weak var sFirstYCard: UILabel!
    @IBOutlet weak var sSecondYCard: UILabel!
    @IBOutlet weak var sFirstRCard: UILabel!
    @IBOutlet weak var sSecondRCard: UILabel!
    @IBOutlet weak var sFirstShoots: UILabel!
    @IBOutlet weak var sSeconsShoots: UILabel!
    @IBOutlet weak var sFirstPasses: UILabel!
    @IBOutlet weak var sSecondPasses: UILabel!
    @IBOutlet weak var sContainerV: UIView!
    
    @IBAction func matchVideoAction(_ sender: Any) {
        if self.videoSelectedView.isHidden {
            self.videoSelectedView.isHidden = false
            self.statesSelectedView.isHidden = true
            self.descSelectView.isHidden = true
        }
        self.videoPlayer.isHidden = false
        self.descLabel.isHidden = true
        self.sContainerV.isHidden = true
    }
    @IBAction func matchStatesAction(_ sender: Any) {
        if self.statesSelectedView.isHidden {
            self.videoSelectedView.isHidden = true
            self.statesSelectedView.isHidden = false
            self.descSelectView.isHidden = true
        }
        self.videoPlayer.isHidden = true
        self.descLabel.isHidden = true
        self.sContainerV.isHidden = false
    }
    @IBAction func matchDescAction(_ sender: Any) {
        if self.descSelectView.isHidden {
            self.videoSelectedView.isHidden = true
            self.statesSelectedView.isHidden = true
            self.descSelectView.isHidden = false
        }
        self.videoPlayer.isHidden = true
        self.descLabel.isHidden = false
        self.sContainerV.isHidden = true
    }
    var matchLink : String?
    var matchResults = MatchResults()
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadow ()
        getMatchResults(onSuccess: { (results) in
            self.matchResults = results
            self.fillData()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
        
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if tableView.tag == 0 {
//            return self.matchResults.data_first!.count
//        }else if tableView.tag == 1 {
//            return self.matchResults.data_second!.count
//        }else{
//            return self.matchResults.data_second!.count
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalsCell", for: indexPath) as! GoalsCell
//        cell.nameLabel.text = self.matchResults.data_first![indexPath.row].name_player
//        cell.timeLabel.text = self.matchResults.data_first![indexPath.row].time_player
//        if tableView == self.firstGoalsTV,
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomOne") as? GoalsCell {
//            return cell
//        }
//
//        return cell
//    }
    
    
    func getMatchResults(onSuccess: @escaping (MatchResults) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getMatchesDetails()
        
        let parameters:[String:Any] = [
            "match_link": self.matchLink!,
            "lang": HelperMethods.getCurrentLanguage()
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    
                    let data = response!["data"]
                    let results = MatchResults(parametersJson: data.dictionaryValue)
                    
                    onSuccess(results)
                    
                }else{
                    let message = response!["Message"].stringValue
                    onFailure(message)
                }
            }
            else
            {
                onFailure(error!.localizedDescription)
            }
        }
    }
    
    func fillData () {
//        self.firstGoalsTV.delegate = self
//        self.firstGoalsTV.dataSource = self
        //            self.secondGoalsTV.delegate = self
        //            self.secondGoalsTV.dataSource = self
//        self.firstGoalsTV.reloadData()
        //            self.secondGoalsTV.reloadData()
        
        self.firstLogoIV.sd_setImage(with: URL(string: Urls.baseUrl + (self.matchResults.first_image ?? "")), placeholderImage: UIImage(named: "main_bg"))
        self.secondLogoIV.sd_setImage(with: URL(string: Urls.baseUrl + (self.matchResults.second_image ?? "")), placeholderImage: UIImage(named: "main_bg"))
        self.firstClubName.text = self.matchResults.first_team
        self.secondClubName.text = self.matchResults.second_team
        self.resultLabel.text = self.matchResults.second_goal! + " - " + self.matchResults.first_goal!
        self.dateLabel.text = self.matchResults.date! + " " + self.matchResults.time!
        let link = self.matchResults.video ?? ""
        let videoID = link.replacingOccurrences(of: "https://www.youtube.com/v/", with: "")
        self.videoPlayer.load(withVideoId: videoID)
        let descriptions = self.matchResults.desc?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        
        self.descLabel.text = descriptions
        self.descLabel.sizeToFit()
        self.sFirstClub.text = self.matchResults.first_team
        self.sSecondClub.text = self.matchResults.second_team
        self.sFirstGoals.text = self.matchResults.first_goal
        self.sSecondGoals.text = self.matchResults.second_goal
        self.sFirstCorners.text = self.matchResults.strikes1
        self.sSecondCorners.text = self.matchResults.strikes2
        self.sFirstOffSide.text = self.matchResults.offside1
        self.sSecondOffSide.text = self.matchResults.offside2
        self.sFirstYCard.text = self.matchResults.cart_yellow1
        self.sSecondYCard.text = self.matchResults.cart_yellow2
        self.sFirstRCard.text = self.matchResults.cart_red1
        self.sSecondRCard.text = self.matchResults.cart_red2
        self.sFirstShoots.text = self.matchResults.paying_goal1
        self.sSeconsShoots.text = self.matchResults.paying_goal2
        self.sFirstPasses.text = self.matchResults.passes1
        self.sSecondPasses.text = self.matchResults.passes2
    }
    
    func addShadow (){
        self.containerView.layer.cornerRadius = 10
        self.containerView.clipsToBounds = true
        self.containerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.175).cgColor
        self.containerView.layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        self.containerView.layer.shadowOpacity = 1.0
        self.containerView.layer.shadowRadius = 4.0
        self.containerView.layer.masksToBounds = false
    }
}
