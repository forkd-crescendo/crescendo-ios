//
//  CrescendoApi.swift
//  crescendo-ios
//
//  Created by Roosevelt Pantaleon on 24/06/18.
//  Copyright © 2018 forkd. All rights reserved.
//

import Foundation

class CrescendoApi {
    
<<<<<<< HEAD
    static let baseUrl = "http://riverarivas.com/crescendo"
=======
    //static let baseUrl = "http://192.168.0.10:3000"
    static let baseUrl = "http://riverarivas.com/crescendo"

>>>>>>> 6af091680924d81e375c7dbe9db04322c154b5af
    
    public static var createArtworkUrl: String {
        return "\(baseUrl)/me/artworks"
    }
    
    public static func updateArtworkUrl(for id: String) -> String {
        return "\(baseUrl)/me/artworks/\(id)"
    }
    
    public static func getArtworks(by userId: String) -> String {
        return "\(baseUrl)/users/\(userId)/artworks"
    }
    
    public static var getAllArtworks: String {
        return "\(baseUrl)/me/favourites/artworks"
    }
    
    public static var createFavoriteUrl: String {
        return "\(baseUrl)/me/favourites"
    }
    
    public static func deleteFavoriteUrl(for id: Int) -> String {
        return "\(baseUrl)/me/favourites/\(id)"
    }
    
    public static var signUpUrl: String {
        return "\(baseUrl)/signup"
    }
    
    public static var authLoginUrl: String {
        return "\(baseUrl)/auth/login"
    }
    
    public static var artistsUrl: String {
        return "\(baseUrl)/users"
    }

    
}
