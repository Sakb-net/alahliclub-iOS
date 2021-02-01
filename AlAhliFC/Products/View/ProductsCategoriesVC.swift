//
//  ProductsCategoriesVC.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/1/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class ProductsCategoriesVC: ParentViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var productsCategoriesCV: UICollectionView!
    
    let presenter = ProductsPresenter()
    var categories = [ProductsCategories]()
    
    var currentPageNumber = 0
    var canLoadMoreData = true
    
    var cartBtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "الأقسام"
        
        productsCategoriesCV.delegate = self
        productsCategoriesCV.dataSource = self
        productsCategoriesCV.addSubview(self.refreshControl)
        
        cartBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        cartBtn.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        cartBtn.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        cartBtn.setImage(#imageLiteral(resourceName: "cart"), for: .normal)
        
        cartBtn.addTarget(self, action: #selector(self.openCart), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartBtn)
        
        if isNetworkReachable {
            getCategories()
        }else{
            self.showAlert(title: "أنت غير متصل الإنترنت", message: "", shouldpop: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCategoriesCell", for: indexPath) as! ProductsCategoriesCell
        cell.configCell(cat: categories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: screenWidth * 0.49, height: screenWidth * 0.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toCategoriesProducts", sender: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastItem = categories.count - 1
        if indexPath.row == lastItem && canLoadMoreData
        {
            currentPageNumber += 1
            getCategories()
        }
    }

    
    func getCategories(){
        self.showLoader()
        presenter.getCategories(numPage: currentPageNumber, onSuccess: { (categories) in
            if categories.isEmpty {
                self.canLoadMoreData = false
            }
            self.categories += categories
            self.productsCategoriesCV.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        getCategories()
        refreshControl.endRefreshing()
    }

    @objc func openCart(_ sender: UIButton) {
        if UserDefaults.standard.object(forKey: "UserCachedData") == nil{
            self.showAlert(title: "", message: "قم بتسجيل الدخول", shouldpop: false)
        }else{
            performSegue(withIdentifier: "toOpenCart", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCategoriesProducts" {
            let index = sender as! Int
            let destination = segue.destination as! CategoriesProductsVC
            destination.catInfo = categories[index]
        }
    }
}
