//
//  SearchCategoryPlayList.swift
//  Spotify
//
//  Created by user212878 on 8/16/22.
//

import Foundation
struct SearchCategoryPlayList: Codable{
    let playlists: CategoryPlayList
}

struct CategoryPlayList: Codable{
    let items: [CategoryItems]
    let total: Int
}
struct CategoryItems: Codable{
    let description: String
    let external_urls:[String:String]
    let id: String
    let images: [image]
    let name: String
    let tracks: CategoryTracks
}
struct CategoryTracks: Codable{
    let total: Int
}
