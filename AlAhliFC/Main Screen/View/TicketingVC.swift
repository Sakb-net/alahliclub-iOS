//
//  TicketingVC.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/9/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import WebKit

class TicketingVC: ParentViewController, UIWebViewDelegate {

    @IBOutlet weak var ticketingSite: WKWebView!
    var ticketingUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "إحجز تذكرتك"
        if let url = URL(string: ticketingUrl){
            let urlRequest = URLRequest(url: url)
            ticketingSite.load(urlRequest)
        }
    }
}
