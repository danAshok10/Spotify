//
//  PlayList.swift
//  Spotify
//
//  Created by user212878 on 6/19/22.
//

import Foundation
struct Playlist: Codable{
    let items: [Item]
}
struct Item: Codable {
    let description: String
    let external_urls: [String:String]
    let id: String
    let images: [image]
    let name: String
    let owner: Owner
    let tracks: Track
}
struct image: Codable {
    let url: String
}
struct Owner: Codable {
    let external_urls: [String:String]
    let display_name: String
    let id: String
    let type: String
}
struct Track: Codable{
    let total: Int
}


