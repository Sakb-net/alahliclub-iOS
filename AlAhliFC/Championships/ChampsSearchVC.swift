//
//  ChampsSearchVC.swift
//  AlAhliFC
//
//  Created by Basma on 9/4/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

protocol ChampsSearch {
    func champsSearch(type: String?)
}

class ChampsSearchVC: ParentViewController, SelectedDropDownType {

    @IBOutlet weak var gameTF: UITextField!
    @IBOutlet weak var typeTF: UITextField!
    @IBOutlet weak var searchBT: UIButton!
    @IBOutlet weak var containerView: UIView!
    var champsSearchProtocol:ChampsSearch!
    var teamList = [Teams]()
    override func viewDidLoad() {
        super.viewDidLoad()
        addLeftViewToTF()
    }
    
    func addLeftViewToTF(){
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "drop_down_arrow"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(gameTF.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.showGamesDropDown), for: .touchUpInside)
        self.gameTF.leftView = button
        self.gameTF.leftViewMode = .always
        
        let button1 = UIButton(type: .custom)
        button1.setImage(UIImage(named: "drop_down_arrow"), for: .normal)
        button1.imageEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        button1.frame = CGRect(x: CGFloat(gameTF.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button1.addTarget(self, action: #selector(self.showTypesDropDown), for: .touchUpInside)
        self.typeTF.leftView = button1
        self.typeTF.leftViewMode = .always
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let touchedView = touch.view, touchedView != containerView {
//                champsSearchProtocol.champsSearch(type: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func showGamesDropDown(_ sender: Any) {
        let dropDownVC = Storyboard().dropDownStoryboard.instantiateViewController(withIdentifier: "DropDownVC") as! DropDownVC
        
        dropDownVC.selectDelegate = self
        dropDownVC.selectedType = .cTeams
        dropDownVC.teamsList = self.teamList
        present(dropDownVC, animated: true
            , completion: nil)
    }
    
    @objc func showTypesDropDown(_ sender: Any) {
    }
    
    func selectedType(selectedType: DropDownTypes, selectedItem: Any) {
//        if selectedType == .cTeams {
//            let selectedCity = selectedItem as! Teams
//            self.city.text = selectedCity.name
//        }
    }

}
