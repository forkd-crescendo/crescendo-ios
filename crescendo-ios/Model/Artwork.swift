//
//  Artwork.swift
//  crescendo-ios
//
//  Created by Roosevelt Pantaleon on 24/06/18.
//  Copyright © 2018 forkd. All rights reserved.
//

import Foundation
import SwiftyJSON

class Artwork {
    var title: String
    var description: String
    var videoId: String
    var userId: String
    var thumbnail: String
    var artistName: String
    
    init(title: String, description: String, videoId: String, userId: String, thumbnail: String, artistName: String) {
        self.title = title
        self.description = description
        self.videoId = videoId
        self.userId = userId
        self.thumbnail = thumbnail
        self.artistName = artistName
    }
    
    convenience init(jsonArtwork: JSON) {
        self.init(title: jsonArtwork["title"].stringValue, description: jsonArtwork["description"].stringValue, videoId: jsonArtwork["videoId"].stringValue, userId: jsonArtwork["created_by"].stringValue, thumbnail: jsonArtwork["thumbnail"].stringValue, artistName: jsonArtwork["artist"].stringValue)
    }
    
    static func buildAll(from jsonArtworks: [JSON]) -> [Artwork] {
        var artworks: [Artwork] = []
        
        for jsonArtwork in jsonArtworks {
            artworks.append(Artwork(jsonArtwork: jsonArtwork))
        }
        
        return artworks
    }
}
