//
//  AudioTrack.swift
//  Spotify
//
//  Created by user212878 on 6/19/22.
//

import Foundation
struct AudioTracks: Codable{
  //  let restrictions: Reason

    var album: Album
    let disc_number: Int
    let duration_ms: Int
    let popularity: Int
    var id: String
    
}
struct Reason: Codable{
    let reason: String
}
struct Album: Codable{
var album_type: String
var artists: [Artist]
var images: [Image]
var id: String
var name: String
let preview_url: String?
var release_date: String
var total_tracks: Int
var type: String
}
/*struct Albums: Codable {
    let album_type: String
    let artists: [Artists]
    let available_markets: [String]
    let external_urls: [String:String]
    let id: String
    let images: [AlbumImage]
    let name: String
    let release_date: String
    let total_tracks: Int
    let type: String
    

}*/
/*struct AlbumImage: Codable {
    let url: String
}*/
/*struct Artists: Codable{
    let external_urls: [String:String]
    let id: String
    let name: String
    let type: String
    let uri: String
}*/

