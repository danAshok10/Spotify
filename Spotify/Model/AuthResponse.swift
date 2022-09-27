//
//  AuthResponse.swift
//  Spotify
//
//  Created by user212878 on 6/27/22.
//

import Foundation
struct AuthResponse: Codable{
    var access_token : String
    var expires_in : Int
    var refresh_token : String?
    var scope : String
    var token_type : String
}




