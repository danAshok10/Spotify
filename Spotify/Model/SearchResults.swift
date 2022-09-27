//
//  SearchResults.swift
//  Spotify
//
//  Created by user212878 on 8/19/22.
//

import Foundation
enum SearchResults{
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTracks)
}
