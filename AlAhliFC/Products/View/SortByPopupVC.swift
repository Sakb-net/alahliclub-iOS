//
//  SortByPopupVC.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/2/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

protocol SortProductsBy {
    func sortBy(type: String?)
}

class SortByPopupVC: ParentViewController {
    
    @IBOutlet weak var sortyByTitle: UILabel!
    @IBOutlet weak var formHightToLowPrice: UIButton!
    @IBOutlet weak var fromLowToHighPrice: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    var sortByDelegate:SortProductsBy!

    override func viewDidLoad() {
        super.viewDidLoad()
        applyDesign()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let touchedView = touch.view, touchedView != containerView {
                sortByDelegate.sortBy(type: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func selectSortType(_ sender: UIButton) {
        if sender.tag == 0 {
            sortByDelegate.sortBy(type: "price_desc")
            dismiss(animated: true, completion: nil)
        }else {
            sortByDelegate.sortBy(type: "price_asc")
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    func applyDesign(){
        sortyByTitle.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        
        formHightToLowPrice.setTitleColor(Color.darkText.value, for: .normal)
        formHightToLowPrice.titleLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        
        fromLowToHighPrice.setTitleColor(Color.darkText.value, for: .normal)
        fromLowToHighPrice.titleLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
    }

}
