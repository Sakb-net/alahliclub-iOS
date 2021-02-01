//
//  AddCommentVC.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/1/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

protocol reloadTVData {
    func updateData()
}
class AddCommentVC: ParentViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userComment: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    
    var presenter = CommentPresneter()
    var link : String?
    var delegate:reloadTVData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "أترك تعليقك"
        applyDesign()

    }
    
    @IBAction func AddCommentAction(_ sender: Any) {
        let name = self.userName.text
        let comment = self.userComment.text
        if name == "" {
            self.showAlert(title: "", message: "ادخل الإسم", shouldpop: true)
        }else if comment == "" {
            self.showAlert(title: "", message: "ادخل محتوى الرسالة", shouldpop: true)

        }else {
        self.showLoader()
            presenter.AddComment(link: link!, content: comment!, user_name: name!, onSuccess: {(message) in
                self.showAlert(title: "", message: message, shouldpop: true)

            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
        }
        self.delegate?.updateData()
    }
    
    func applyDesign() {
        userName.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        userName.textColor = Color.darkText.value
        
        userComment.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        userComment.textColor = Color.darkText.value
        userComment.layer.cornerRadius = 10
        userComment.layer.borderWidth = 1
        userComment.layer.borderColor = Color.border.value.cgColor
        
        sendBtn.setTitleColor(UIColor.white, for: .normal)
        sendBtn.layer.cornerRadius = 10
        sendBtn.titleLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        userName.textColor = Color.darkText.value
        sendBtn.backgroundColor = Color.theme.value
    }
}
