//
//  AboutClubVC.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/8/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class AboutClubVC: ParentViewController {
    var presenter = AboutClubPresenter()
    var aboutClub = AboutClub()
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var containerV: UIView!
    @IBOutlet weak var firstTitleL: UILabel!
    @IBOutlet weak var firstContentL: UILabel!
    @IBOutlet weak var firstL: UILabel!
    @IBOutlet weak var secondL: UILabel!
    @IBOutlet weak var thirdL: UILabel!
    @IBOutlet weak var secondTitleL: UILabel!
    @IBOutlet weak var secondContentL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "عن النادي"
        
        menuBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        menuBtn.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        
        menuBtn.addTarget(self, action: #selector(self.openSideMenu), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuBtn)
        self.containerV.layer.cornerRadius = 10
        self.containerV.clipsToBounds = true
        self.showLoader()
        presenter.getAboutClub(onSuccess: { (aboutClub) in
            self.aboutClub = aboutClub
            self.firstTitleL.text = aboutClub.title_one
            self.secondTitleL.text = aboutClub.title_two
            self.firstContentL.text = aboutClub.content_one
            self.secondContentL.text = aboutClub.content_two
            self.firstL.text = aboutClub.all_list![0]
            self.secondL.text = aboutClub.all_list![1]
            self.thirdL.text = aboutClub.all_list![2]
            self.imageV.sd_setImage(with: URL(string: Urls.baseUrl + (aboutClub.image ?? "")), placeholderImage: UIImage(named: "main_bg"))
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
        }
    }
    

    //Side Menu
    @objc func openSideMenu(_ sender: UIButton) {
        performSegue(withIdentifier: "openMenu", sender: nil)
    }
}
