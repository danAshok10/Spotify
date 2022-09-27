//
//  Settings.swift
//  Spotify
//
//  Created by user212878 on 7/4/22.
//

import Foundation
struct Section {
    let title: String
    let option: [Option]
}
struct Option {
    let title: String
    let handler: () -> Void
}
