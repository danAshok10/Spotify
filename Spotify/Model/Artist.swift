//
//  Artist.swift
//  Spotify
//
//  Created by user212878 on 6/19/22.
//

import Foundation
struct Artist: Codable {
    var id : String
    var name: String
    var type: String
    let images: [Image]?
    let external_urls: [String:String]
   // var uri: String
}
