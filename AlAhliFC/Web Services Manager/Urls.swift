//
//  Urls.swift
//  StarterProject
//
//  Created by Mohammed Saleh on 2/2/19.
//  Copyright © 2019 me. All rights reserved.
//

import Foundation

enum AppEnvironments {
    case development, production
}

class Urls {
    
    static let apiAccessKey = "access-token"
    static let apiAccessKeyValue = User.shared().access_token ?? ""
    static let baseUrl = "http://alahliclub.sakb.net"
    
    private let currentWorkingEnvironment = AppEnvironments.development
    
    private var developmentServerBaseURL:String
    {
        return "http://alahliclub.sakb.net/api/v1/"
    }
    
    private var ProducationServerBaseURL:String
    {
        return "http://alahliclub.sakb.net/api/v1/"
    }
    
    private func getCurrentBaseUrl() -> String{
        if currentWorkingEnvironment == .development {
            return developmentServerBaseURL
        }else{
            return ProducationServerBaseURL
        }
    }
    
    func urlEncoding(originalString: String) -> String {
        return originalString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
    
    func getCountryURL() -> String {
        return "\(getCurrentBaseUrl())get_country"
    }
    
    func getCityURL() -> String {
        return "\(getCurrentBaseUrl())get_city"
    }
    
    func getLoginURL() -> String {
        return "\(getCurrentBaseUrl())login/email"
    }
    
    func getRegisterURL() -> String {
        return "\(getCurrentBaseUrl())register"
    }
    
    func getHomeURL() -> String {
        return "\(getCurrentBaseUrl())home"
    }
    
    func getAlbumsURL() -> String {
        return "\(getCurrentBaseUrl())albums"
    }
    
    func getAlbumImagesURL() -> String {
        return "\(getCurrentBaseUrl())albums/single"
    }
    
    func getVideosURL() -> String {
        return "\(getCurrentBaseUrl())videos"
    }
    
    func getVedioDetailsURL() -> String {
        return "\(getCurrentBaseUrl())videos/single"
    }
    
    func getNewsURL() -> String {
        return "\(getCurrentBaseUrl())news"
    }
    
    func getNewsDetailsURL() -> String {
        return "\(getCurrentBaseUrl())news/single"
    }
    
    func getCommentsURL() -> String {
        return "\(getCurrentBaseUrl())comments"
    }
    
    func getAddCommentURL() -> String {
        return "\(getCurrentBaseUrl())add_comment"
    }
    
    func getMatchesURL() -> String {
        return "\(getCurrentBaseUrl())matches"
    }
    
    func getCategoriesURL() -> String {
        return "\(getCurrentBaseUrl())product_categories"
    }
    
    func getProductsURL() -> String {
        return "\(getCurrentBaseUrl())product_category"
    }
    
    func getCartProductsURL() -> String {
        return "\(getCurrentBaseUrl())product_cart"
    }
    
    func getAddCartItemsURL() -> String {
        return "\(getCurrentBaseUrl())product/addupdate_cart"
    }
    
    func getDeleteCartItemsURL() -> String {
        return "\(getCurrentBaseUrl())product/delete_cart"
    }
    
    func getCheckoutURL() -> String {
        return "\(getCurrentBaseUrl())product/checkout"
    }
    
    func getPaymentStatusURL() -> String {
        return "\(getCurrentBaseUrl())product/resultcallback"
    }
    
    func updateProfile() -> String {
        return "\(getCurrentBaseUrl())update_profile"
    }
    
    func getChampioships() -> String {
        return "\(getCurrentBaseUrl())champions"
    }
    
    func getTeams() -> String {
        return "\(getCurrentBaseUrl())teams"
    }
    
    func getPlayers() -> String {
        return "\(getCurrentBaseUrl())subteams"
    }
    
    func getAboutClub() -> String {
        return "\(getCurrentBaseUrl())about"
    }
    
    func getCalender() -> String {
        return "\(getCurrentBaseUrl())calendar"
    }
    
    func getAudience() -> String {
        return "\(getCurrentBaseUrl())audience"
    }
    
    func getMatchesDetails() -> String {
        return "\(getCurrentBaseUrl())matches/single"
    }
    
    func sendMessage() -> String {
        return "\(getCurrentBaseUrl())add_contact_us"
    }
}
