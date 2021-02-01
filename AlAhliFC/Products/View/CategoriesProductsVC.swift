//
//  CategoriesProductsVC.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/2/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class CategoriesProductsVC: ParentViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SortProductsBy {
    
    @IBOutlet weak var numberOfProducts: UILabel!
    @IBOutlet weak var categoriesProductsCV: UICollectionView!
    
    let presenter = ProductsPresenter()
    var products = [Products]()
    
    var currentPageNumber = 0
    var canLoadMoreData = true
    var catInfo:ProductsCategories!
    var valSort = "price_asc"
    
    var cartBtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = catInfo.name ?? ""
        
        cartBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        cartBtn.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        cartBtn.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        cartBtn.setImage(#imageLiteral(resourceName: "cart"), for: .normal)
        
        cartBtn.addTarget(self, action: #selector(self.openCart), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartBtn)
        
        categoriesProductsCV.delegate = self
        categoriesProductsCV.dataSource = self
        
        numberOfProducts.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        numberOfProducts.textColor = Color.darkText.value
        
        categoriesProductsCV.addSubview(self.refreshControl)
        
        numberOfProducts.text = String(catInfo.products_count ?? 0) + " " + "منتج"
        
        if isNetworkReachable {
            getProducts()
        }else{
            self.showAlert(title: "أنت غير متصل الإنترنت", message: "", shouldpop: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesProductsCell", for: indexPath) as! CategoriesProductsCell
        cell.configCell(product: products[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: screenWidth * 0.49, height: screenWidth * 0.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toProductDetails", sender: indexPath.row)
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        let lastItem = products.count - 1
//        if indexPath.row == lastItem && canLoadMoreData
//        {
//            currentPageNumber += 1
//            getProducts()
//        }
//    }
    
    @IBAction func toSortBy(_ sender: UIButton) {
        performSegue(withIdentifier: "toSortByPopup", sender: nil)
    }
    
    func getProducts(){
        self.showLoader()
        presenter.getProducts(catLink: catInfo.link ?? "", numPage: currentPageNumber, valSort: valSort, onSuccess: { (products) in
            if products.isEmpty {
                self.canLoadMoreData = false
            }
            self.products += products
            self.categoriesProductsCV.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func sortBy(type: String?) {
        products.removeAll()
        guard let sortType = type else {
            return
        }
        
        self.valSort = sortType
        getProducts()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        getProducts()
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
        if segue.identifier == "toSortByPopup" {
            let destination = segue.destination as! SortByPopupVC
            destination.sortByDelegate = self
        }else if segue.identifier == "toProductDetails" {
            let index = sender as! Int
            let destination = segue.destination as! ProductDetailsVC
            destination.product = products[index]
        }
    }

}
