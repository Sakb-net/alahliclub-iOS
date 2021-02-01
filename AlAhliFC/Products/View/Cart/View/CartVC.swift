//
//  CartVC.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/18/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class CartVC: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cartTV: UITableView!
    
    var cartItems = [CartItems]()
    var cartFees = [Fees]()
    var totalPriceCart = 0
    var checkoutInfo:Checkout!
    
    let presenter = CartPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "السلة"
        cartTV.delegate = self
        cartTV.dataSource = self
        
        if isNetworkReachable {
            getCartProducts()
        }else{
            self.showAlert(title: "أنت غير متصل الإنترنت", message: "", shouldpop: false)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return cartItems.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            tableView.rowHeight = 180
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
            cell.configCell(cartItem: cartItems[indexPath.row], tag: indexPath.row)
            return cell
        }else{
            tableView.rowHeight = CGFloat(((cartFees.count + 2) * 40) + 100)
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartReceiptCell", for: indexPath) as! CartReceiptCell
            cell.configCell(cartFees: cartFees, cartTotalPrice: totalPriceCart)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "CartHeaderCell") as! CartHeaderCell
        if section == 0 {
            let title = "منتج" + " (" + String(cartItems.count) + ")"
            headerCell.configCell(title: title)
        }else{
            headerCell.configCell(title: "التفاصيل")
        }
        return headerCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    func getCartProducts(){
        self.showLoader()
        presenter.getCartProducts(onSuccess: { (cartItems, cartFees, totalPriceCart) in
            
            self.cartItems = cartItems
            self.cartFees = cartFees
            self.totalPriceCart = totalPriceCart
            self.cartTV.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    @IBAction func removeItemFromCart(_ sender: UIButton) {
        let item = cartItems[sender.tag]
        if isNetworkReachable {
            deleteItemFromCart(link: item.link ?? "")
        }else{
            self.showAlert(title: "أنت غير متصل الإنترنت", message: "", shouldpop: false)
        }
    }
    
    @IBAction func orderNow(_ sender: UIButton) {
        if isNetworkReachable {
            orderNow()
        }else{
            self.showAlert(title: "أنت غير متصل الإنترنت", message: "", shouldpop: false)
        }
    }
    
    func orderNow(){
        presenter.checkout(onSuccess: { (checkoutData) in
            self.checkoutInfo = checkoutData
            self.hideLoader()
            
            let provider = OPPPaymentProvider(mode: OPPProviderMode.test)
            let checkoutSettings = OPPCheckoutSettings()
            checkoutSettings.paymentBrands = ["VISA", "DIRECTDEBIT_SEPA"]
            checkoutSettings.shopperResultURL = checkoutData.shopperResultUrl ?? ""
            
            let checkoutProvider = OPPCheckoutProvider(paymentProvider: provider, checkoutID: checkoutData.checkoutId ?? "", settings: checkoutSettings)
            
            checkoutProvider?.presentCheckout(forSubmittingTransactionCompletionHandler: { (transaction, error) in
                guard let transaction = transaction else {
                    // Handle invalid transaction, check error
                    self.showAlert(title: "", message: "nvalid transaction", shouldpop: false)
                    return
                }
                
                if transaction.type == .synchronous {
                    // If a transaction is synchronous, just request the payment status
                    // You can use transaction.resourcePath or just checkout ID to do it
                    self.getPaymentStatus()
                } else if transaction.type == .asynchronous {
                    // The SDK opens transaction.redirectUrl in a browser
                    // See 'Asynchronous Payments' guide for more details
                } else {
                    // Executed in case of failure of the transaction for any reason
                }
            }, cancelHandler: {
                // Executed if the shopper closes the payment page prematurely
            })
            
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func getPaymentStatus(){
        self.showLoader()
        presenter.getPaymentStatus(checkoutId: checkoutInfo.checkoutId ?? "", onSuccess: { (paymenyStatus) in
            self.showAlert(title: "", message: paymenyStatus.mesage_pay, shouldpop: false)
            self.getCartProducts()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func deleteItemFromCart(link:String){
        presenter.deleteItemToCart(itemLink: link, onSuccess:  { () in
            self.getCartProducts()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    
}
