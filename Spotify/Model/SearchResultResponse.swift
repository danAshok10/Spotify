//
//  SearchResultResponse.swift
//  Spotify
//
//  Created by user212878 on 8/19/22.
//

import Foundation

struct SearchResultResponse: Codable{
    let albums: SearchAlbumsResponse
    let artists: SearchArtistsResponse
    let tracks: SearchTracksResponse
}

struct SearchAlbumsResponse: Codable{
    let items: [Album]
}

struct SearchArtistsResponse: Codable{
    let items: [Artist]
}

struct SearchTracksResponse: Codable{
    let items: [AudioTracks]
}
