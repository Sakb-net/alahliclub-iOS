//
//  DropDownVC.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/12/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

enum DropDownTypes: String {
    case Country = "country"
    case City = "city"
    case cTeams = "teams"
    case subTeams = "subteams"
}

protocol SelectedDropDownType {
    func selectedType(selectedType:DropDownTypes, selectedItem:Any)
}

class DropDownVC: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dropDownTV: UITableView!
    @IBOutlet weak var containerView: CardView!
    
    var selectedType = DropDownTypes.Country
    let presenter = DropDownPresenter()
    
    var countries = Country()
    var cities = [City]()
    
    var selectDelegate:SelectedDropDownType!
    
    var teamsList = [Teams]()
    var supTeams = [SubTeams]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dropDownTV.delegate = self
        dropDownTV.dataSource = self
        self.tableView.separatorStyle = .none

        if isNetworkReachable {
            if selectedType == .Country {
                 getCountries()
            }else if selectedType == .City {
                getCities()
            }
           
        }else{
            self.showAlert(title: "أنت غير متصل الإنترنت", message: "", shouldpop: false)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let touchedView = touch.view, touchedView != containerView {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch selectedType {
        case .Country:
            return 1
        case .City:
            return cities.count
        case .cTeams:
            return self.teamsList.count
        case .subTeams:
            return self.supTeams.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dropDownCell", for: indexPath)
        cell.textLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        cell.textLabel?.textColor = Color.theme.value
        cell.textLabel?.textAlignment = .right
        cell.textLabel?.numberOfLines = 0
        
        switch selectedType {
        case .Country:
           cell.textLabel?.text = countries.name
        case .City:
             cell.textLabel?.text = cities[indexPath.row].name
        case .cTeams:
            cell.textLabel?.text = self.teamsList[indexPath.row].name
        case .subTeams:
            cell.textLabel?.text = self.supTeams[indexPath.row].name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedType == .Country {
            self.selectDelegate.selectedType(selectedType: .Country, selectedItem: countries)
        }else if selectedType == .City {
            self.selectDelegate.selectedType(selectedType: .City, selectedItem: cities[indexPath.row])
        }else if selectedType == .subTeams {
            self.selectDelegate.selectedType(selectedType: .City, selectedItem: self.supTeams[indexPath.row])
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func getCountries(){
        self.showLoader()
        presenter.getCountries(onSuccess: { (coutries) in
            self.countries = coutries
            self.dropDownTV.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func getCities(){
        self.showLoader()
        presenter.getCities(onSuccess: { (cities) in
            self.cities = cities
            self.dropDownTV.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
}
