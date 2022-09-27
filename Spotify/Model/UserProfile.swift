//
//  UserProfile.swift
//  Spotify
//
//  Created by user212878 on 6/19/22.
//

import Foundation

struct UserProfile: Decodable{
    let country: String
    let display_name: String
   // let email: String
   let external_urls: [String:String]
    let explicit_content: [String:Bool]
    let id: String
    let images: [UserImages]
    let product: String
    
}
struct UserImages: Decodable{
    let url: String 
}
/*Optional({
    country = IN;
    "display_name" = Danashok;
    "explicit_content" =     {
        "filter_enabled" = 0;
        "filter_locked" = 0;
    };
    "external_urls" =     {
        spotify = "https://open.spotify.com/user/313nel6rg4ew5k6r5wwvwosen52m";
    };
    followers =     {
        href = "<null>";
        total = 0;
    };
    href = "https://api.spotify.com/v1/users/313nel6rg4ew5k6r5wwvwosen52m";
    id = 313nel6rg4ew5k6r5wwvwosen52m;
    images =     (
                {
            height = "<null>";
            url = "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=572755406156996&height=300&width=300&ext=1659209858&hash=AeQ2H2khiTw7iRfwEYI";
            width = "<null>";
        }
    );
    product = open;
    type = user;
    uri = "spotify:user:313nel6rg4ew5k6r5wwvwosen52m";
})*/
