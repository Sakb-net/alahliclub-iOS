//
//  CalenderVC.swift
//  AlAhliFC
//
//  Created by Basma on 9/17/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class CalenderVC: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    var presenter = CalenderPresenter()
    var calendars = [CalenderModel]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.calendars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        cell.contentLabel.text = self.calendars[indexPath.row].name
        cell.dateLabel.text = self.calendars[indexPath.row].date
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        menuBtn.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        menuBtn.addTarget(self, action: #selector(self.openSideMenu), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuBtn)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
//        self.tableView.separatorStyle = .none
        self.showLoader()
        presenter.getCalendars(onSuccess: {(calendarItems) in
            self.calendars = calendarItems
            self.tableView.reloadData()
            self.hideLoader()
    }) { (errorMessage) in
        self.hideLoader()
    }
}
    
    @objc func openSideMenu(_ sender: UIButton) {
        performSegue(withIdentifier: "openMenu", sender: nil)
    }
}
