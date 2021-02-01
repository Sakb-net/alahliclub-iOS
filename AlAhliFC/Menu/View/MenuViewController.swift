//
//  MenuViewController.swift
//  StarterProject
//
//  Created by Mohammed Saleh on 2/4/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SideMenu

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuTV: UITableView!
    
    var menuItems = [(id:String, name:String)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTV.delegate = self
        menuTV.dataSource = self
        menuTV.rowHeight = 70
        
        menuItems.append(("main","الرئيسية"))
        menuItems.append(("about", "عن النادي"))
        menuItems.append(("news", "الأخبار"))
        menuItems.append(("team", "الفرق"))
        //menuItems.append(("other","ألعاب أخرى"))
        menuItems.append(("matches","المباريات"))
        //menuItems.append(("resualts", "النتائج"))
        menuItems.append(("roz","روزنامة"))
        menuItems.append(("champ","البطولات"))
        menuItems.append(("consalt", "مجلس الجمهور"))
        //menuItems.append(("blot", "لعبة بلوت"))
        if let _ = User.shared().access_token {
            menuItems.insert(("profile", "profile"), at: 0)
            menuItems.append(("myAccount", "حسابي"))
            menuItems.append(("contactUs","اتصل بنا"))
            menuItems.append(("logout", "تسجيل الخروج"))
        }else{
            menuItems.insert(("login", "login"), at: 0)
            menuItems.append(("contactUs","اتصل بنا"))
        }
        
        
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuPushStyle = .replace
        SideMenuManager.default.menuWidth = 270
        SideMenuManager.default.menuPresentMode = .menuSlideIn
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if User.shared().access_token != nil && indexPath.row == 0 {
            tableView.rowHeight = 90
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuProfileCell", for: indexPath) as! MenuProfileCell
            cell.configCell()
            return cell
        }else if User.shared().access_token == nil && indexPath.row == 0 {
            tableView.rowHeight = 70
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuLoginCell", for: indexPath) as! MenuLoginCell
            cell.configCell()
            return cell
        }else{
            tableView.rowHeight = 60
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
            cell.configCell(title: menuItems[indexPath.row].name)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if menuItems[indexPath.row].id == "login" {
            let loginVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(loginVC, animated: true)
            
        }else if menuItems[indexPath.row].id == "main" {
            let mainVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "MainScreenVC") as! MainScreenVC
            self.navigationController?.pushViewController(mainVC, animated: true)
        }else if menuItems[indexPath.row].id == "contactUs" {
            let mainVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
            self.navigationController?.pushViewController(mainVC, animated: true)
        }else if menuItems[indexPath.row].id == "about" {
            let mainVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "AboutClubVC") as! AboutClubVC
            self.navigationController?.pushViewController(mainVC, animated: true)
        }else if menuItems[indexPath.row].id == "profile" || menuItems[indexPath.row].id == "myAccount"  {
            let mainVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "MyProfileVC") as! MyProfileVC
            self.navigationController?.pushViewController(mainVC, animated: true)
        }else if menuItems[indexPath.row].id == "news" {
            let mainVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "NewsListVC") as! NewsListVC
            self.navigationController?.pushViewController(mainVC, animated: true)
        }else if menuItems[indexPath.row].id == "matches" {
            let mainVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "MatchesVC") as! MatchesVC
            self.navigationController?.pushViewController(mainVC, animated: true)
        }else if menuItems[indexPath.row].id == "logout" {
            User.shared().logoutUser()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = Storyboard().mainStoryboard.instantiateInitialViewController()
        }else if menuItems[indexPath.row].id == "champ"{
            let champsVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "ChampionshipsVC") as! ChampionshipsVC
            self.navigationController?.pushViewController(champsVC, animated: true)
        }else if menuItems[indexPath.row].id == "team"{
            let teamsVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "TeamsVC") as! TeamsVC
            self.navigationController?.pushViewController(teamsVC, animated: true)
        }else if menuItems[indexPath.row].id == "roz"{
            let rozVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "CalenderVC") as! CalenderVC
            self.navigationController?.pushViewController(rozVC, animated: true)
        }else if menuItems[indexPath.row].id == "consalt"{
            let audienceVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "AudienceVC") as! AudienceVC
            self.navigationController?.pushViewController(audienceVC, animated: true)
        }
        
    }
    
}
