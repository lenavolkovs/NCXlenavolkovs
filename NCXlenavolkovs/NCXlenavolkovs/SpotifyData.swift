//
//  SpotifyData.swift
//  NCXlenavolkovs
//
//  Created by Elena Volkova on 27/03/24.
//

import Foundation

struct SpotifyResponse: Codable {
    var tracks: Track
}

struct Track: Codable {
    var items: [Item]
}

struct Item: Codable, Identifiable {
    var id: String
    var name: String
    var popularity: Int
    var artists: [Artist]
    var album: Album
}

struct Artist: Codable {
    var name: String
}

struct Album: Codable {
    var name: String
//    var images: [Image]
}

//struct Image: Codable {
//    var heigth: Int
//    var url: String
//    var width: Int
//}
