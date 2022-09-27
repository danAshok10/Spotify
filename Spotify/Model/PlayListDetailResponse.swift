//
//  PlayListDetailResponse.swift
//  Spotify
//
//  Created by user212878 on 7/27/22.
//

import Foundation
struct PlaylistDetailResponse: Codable{
    let description: String
    let external_urls:[String:String]
    let id: String
    let images: [Image]
    let name: String
    let tracks: PlayListTrackResponse
}
struct PlayListTrackResponse: Codable{
    let items: [PlayListItems]
}
struct PlayListItems: Codable {
    let track: AudioTracks
}
