//
//  SearchCategories.swift
//  Spotify
//
//  Created by user212878 on 8/15/22.
//

import Foundation

struct SearchCategories: Codable{
    let categories: SearchCategory
}

struct SearchCategory: Codable {
    let items: [SearchItem]
    let total: Int
}

struct SearchItem: Codable {
    let icons: [image]
    let id: String
    let name: String
}
