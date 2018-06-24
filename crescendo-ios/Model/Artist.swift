//
//  Artist.swift
//  crescendo-ios
//
//  Created by Roosevelt Pantaleon on 03/06/18.
//  Copyright © 2018 forkd. All rights reserved.
//

import Foundation
import SwiftyJSON

class Artist {
    var id: String
    var name: String
    var genre: String
    var biography: String
    var photoUrl: String
    
    init(id: String, name: String, genre: String, biography: String, photoUrl: String) {
        self.id = id
        self.name = name
        self.genre = genre
        self.biography = biography
        self.photoUrl = photoUrl
    }
    
    convenience init(jsonArtist: JSON) {
        self.init(id: jsonArtist["id"].stringValue, name: jsonArtist["name"].stringValue, genre: jsonArtist["genre"].stringValue, biography: jsonArtist["bio"].stringValue, photoUrl: jsonArtist["photo"].stringValue)
    }
    
    static func buildAll(from jsonArtists: [JSON]) -> [Artist] {
        var artists: [Artist] = []
        
        for jsonArtist in jsonArtists {
            artists.append(Artist(jsonArtist: jsonArtist))
        }
        return artists
    }
    
}
