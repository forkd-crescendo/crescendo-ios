//
//  CrescendoApi.swift
//  crescendo-ios
//
//  Created by Roosevelt Pantaleon on 24/06/18.
//  Copyright © 2018 forkd. All rights reserved.
//

import Foundation

class CrescendoApi {
    
    static let baseUrl = "http://192.168.0.10:3000"
    
    public static var createArtworkUrl: String {
        return "\(baseUrl)/me/artworks"
    }
    
    public static func updateArtworkUrl(for id: String) -> String {
        return "\(baseUrl)/me/artworks/\(id)"
    }
    
    public static func getArtworks(by userId: String) -> String {
        return "\(baseUrl)/users/\(userId)/artworks"
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
