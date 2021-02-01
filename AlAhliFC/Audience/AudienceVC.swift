//
//  AudienceVC.swift
//  AlAhliFC
//
//  Created by Basma on 9/19/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class AudienceVC: ParentViewController{
    @IBOutlet weak var cBox1: UIButton!
    @IBOutlet weak var cBox2: UIButton!
    @IBOutlet weak var cBox3: UIButton!
    @IBOutlet weak var cBox4: UIButton!
    @IBOutlet weak var answerLabel1: UILabel!
    @IBOutlet weak var answerLabel2: UILabel!
    @IBOutlet weak var answerLabel3: UILabel!
    @IBOutlet weak var answerLabel4: UILabel!
    @IBOutlet weak var rateLabel1: UILabel!
    @IBOutlet weak var rateLabel2: UILabel!
    @IBOutlet weak var rateLabel3: UILabel!
    @IBOutlet weak var rateLabel4: UILabel!
    @IBOutlet weak var pbar1: UIProgressView!
    @IBOutlet weak var pbar2: UIProgressView!
    @IBOutlet weak var pbar3: UIProgressView!
    @IBOutlet weak var pbar4: UIProgressView!
    @IBOutlet weak var submitBT: UIButton!
    
    var cBoxSelected1 = false
    var cBoxSelected2 = false
    var cBoxSelected3 = false
    var cBoxSelected4 = false
    @IBAction func SubmitAction(_ sender: Any) {
    }
    
    @IBAction func cBoxAction1(_ sender: Any) {
        if !cBoxSelected1{
            self.cBox1.backgroundColor = Color.theme.value
            self.cBox2.backgroundColor = UIColor.white
            self.cBox3.backgroundColor = UIColor.white
            self.cBox4.backgroundColor = UIColor.white
            cBoxSelected1 = true
            cBoxSelected2 = false
            cBoxSelected3 = false
            cBoxSelected4 = false
        }else {
            self.cBox1.backgroundColor = UIColor.white
            cBoxSelected1 = false
        }
    }
    
    @IBAction func cBoxAction2(_ sender: Any) {
        if !cBoxSelected2{
            self.cBox2.backgroundColor = Color.theme.value
            self.cBox1.backgroundColor = UIColor.white
            self.cBox3.backgroundColor = UIColor.white
            self.cBox4.backgroundColor = UIColor.white
            cBoxSelected2 = true
            cBoxSelected1 = false
            cBoxSelected3 = false
            cBoxSelected4 = false
        }else {
            self.cBox2.backgroundColor = UIColor.white
            cBoxSelected2 = false
        }
    }
    
    @IBAction func cBoxAction3(_ sender: Any) {
        if !cBoxSelected3{
            self.cBox3.backgroundColor = Color.theme.value
            self.cBox2.backgroundColor = UIColor.white
            self.cBox1.backgroundColor = UIColor.white
            self.cBox4.backgroundColor = UIColor.white
            cBoxSelected3 = true
            cBoxSelected2 = false
            cBoxSelected1 = false
            cBoxSelected4 = false
        }else {
            self.cBox3.backgroundColor = UIColor.white
            cBoxSelected3 = false
        }
    }
    
    @IBAction func cBoxAction4(_ sender: Any) {
        if !cBoxSelected4{
            self.cBox4.backgroundColor = Color.theme.value
            self.cBox2.backgroundColor = UIColor.white
            self.cBox3.backgroundColor = UIColor.white
            self.cBox1.backgroundColor = UIColor.white
            cBoxSelected4 = true
            cBoxSelected2 = false
            cBoxSelected3 = false
            cBoxSelected1 = false
        }else {
            self.cBox4.backgroundColor = UIColor.white
            cBoxSelected4 = false
        }
    }
    var audience = QuestionDetails()
    var questionsAnswers = [anwsers]()
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        menuBtn.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        menuBtn.addTarget(self, action: #selector(self.openSideMenu), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuBtn)

        roundCBox(view:self.cBox1)
        roundCBox(view:self.cBox2)
        roundCBox(view:self.cBox3)
        roundCBox(view:self.cBox4)
        customDesignForPBars()
        self.submitBT.layer.cornerRadius = 6
        self.pbar1.semanticContentAttribute = .forceRightToLeft
        self.pbar2.semanticContentAttribute = .forceRightToLeft
        self.pbar3.semanticContentAttribute = .forceRightToLeft
        self.pbar4.semanticContentAttribute = .forceRightToLeft

        self.showLoader()
        getQuestionDetails(onSuccess: {(questionAnswers) in
            self.audience = questionAnswers
            self.fillData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
        }

    }
    
    func getQuestionDetails(onSuccess: @escaping (QuestionDetails) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getAudience()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage()
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
                    
                    var questionDetails = QuestionDetails()

                    if let sName = response!["data"]["name"].string{
                        questionDetails.name = sName

                    }
                    if let rate = response!["data"]["rate"].string{
                        questionDetails.rate = rate
                    }
                    if let link = response!["data"]["link"].string{
                        questionDetails.link = link
                    }
                    if let created_at = response!["data"]["created_at"].string{
                        questionDetails.created_at = created_at
                    }
                    if let content = response!["data"]["content"].string{
                        questionDetails.content = content
                    }
                    var qAnswers = [anwsers]()
                    if let allanwsers = response!["data"]["anwsers"].array
                    {
                        for answer in allanwsers {
                            qAnswers.append(anwsers(parametersJson: answer.dictionaryValue))
                        }
                        questionDetails.questionAnwsers = qAnswers
                        self.questionsAnswers = qAnswers
                    }
                    onSuccess(questionDetails)
                    
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
    func fillData (){
        
        self.answerLabel1.text = self.questionsAnswers[0].name
        self.answerLabel2.text = self.questionsAnswers[1].name
        self.answerLabel3.text = self.questionsAnswers[2].name
        self.answerLabel4.text = self.questionsAnswers[3].name
        let allRates = Float(self.questionsAnswers[0].rate!)! + Float(self.questionsAnswers[1].rate!)! + Float(self.questionsAnswers[2].rate!)! + Float(self.questionsAnswers[3].rate!)!
        let rate1 = Float(self.questionsAnswers[0].rate!)! / allRates
        let rate2 = Float(self.questionsAnswers[1].rate!)! / allRates
        let rate3 = Float(self.questionsAnswers[2].rate!)! / allRates
        let rate4 = Float(self.questionsAnswers[3].rate!)! / allRates
        self.rateLabel1.text  = "(" + self.questionsAnswers[0].rate! + "%)"
        self.rateLabel2.text  = "(" + self.questionsAnswers[1].rate! + "%)"
        self.rateLabel3.text  = "(" + self.questionsAnswers[2].rate! + "%)"
        self.rateLabel4.text  = "(" + self.questionsAnswers[3].rate! + "%)"
        self.pbar1.setProgress(rate1, animated: true)
        self.pbar2.setProgress(rate2, animated: true)
        self.pbar3.setProgress(rate3, animated: true)
        self.pbar4.setProgress(rate4, animated: true)
        
    }
    func roundCBox(view : UIView){
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
    }
    
    func customDesignForPBars(){
        self.pbar1.transform = self.pbar1.transform.scaledBy(x: 1, y: 6)
        self.pbar2.transform = self.pbar2.transform.scaledBy(x: 1, y: 6)
        self.pbar3.transform = self.pbar3.transform.scaledBy(x: 1, y: 6)
        self.pbar4.transform = self.pbar4.transform.scaledBy(x: 1, y: 6)
        self.pbar1.layer.cornerRadius = 4
        self.pbar1.clipsToBounds = true
        self.pbar2.layer.cornerRadius = 4
        self.pbar2.clipsToBounds = true
        self.pbar3.layer.cornerRadius = 4
        self.pbar3.clipsToBounds = true
        self.pbar4.layer.cornerRadius = 4
        self.pbar4.clipsToBounds = true
    }
    @objc func openSideMenu(_ sender: UIButton) {
        performSegue(withIdentifier: "openMenu", sender: nil)
    }
}
