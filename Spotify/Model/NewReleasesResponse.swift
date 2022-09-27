//
//  NewReleasesResponse.swift
//  Spotify
//
//  Created by user212878 on 7/8/22.
//

import Foundation
struct NewReleasesResponse: Codable{
    var albums: AlbumsResponse
}
struct AlbumsResponse: Codable{
    var items: [Album]
    let href : String
}
/*struct  Album: Codable {
    var album_type: String
    var artists: [Artist]
    var images: [Image]
    var id: String
    var name: String
    var release_date: String
   var total_tracks: Int
   var type: String
    
}*/
struct Image: Codable{
    var url: String
    
}



/*items =         (
                {
        "album_type" = single;
        artists =                 (
                                {
                "external_urls" =                         {
                    spotify = "https://open.spotify.com/artist/4kYSro6naA4h99UJvo89HB";
                };
                href = "https://api.spotify.com/v1/artists/4kYSro6naA4h99UJvo89HB";
                id = 4kYSro6naA4h99UJvo89HB;
                name = "Cardi B";
                type = artist;
                uri = "spotify:artist:4kYSro6naA4h99UJvo89HB";
            },
                                {
                "external_urls" =                         {
                    spotify = "https://open.spotify.com/artist/5K4W6rqBFWDnAN6FQUkS6x";
                };
                href = "https://api.spotify.com/v1/artists/5K4W6rqBFWDnAN6FQUkS6x";
                id = 5K4W6rqBFWDnAN6FQUkS6x;
                name = "Kanye West";
                type = artist;
                uri = "spotify:artist:5K4W6rqBFWDnAN6FQUkS6x";
            },
                                {
                "external_urls" =                         {
                    spotify = "https://open.spotify.com/artist/3hcs9uc56yIGFCSy9leWe7";
                };
                href = "https://api.spotify.com/v1/artists/3hcs9uc56yIGFCSy9leWe7";
                id = 3hcs9uc56yIGFCSy9leWe7;
                name = "Lil Durk";
                type = artist;
                uri = "spotify:artist:3hcs9uc56yIGFCSy9leWe7";
            }
        );
        "available_markets" =                 (
     
            ZW
        );
        "external_urls" =                 {
            spotify = "https://open.spotify.com/album/2qTIltFPwJzsyssGeOwdRO";
        };
        href = "https://api.spotify.com/v1/albums/2qTIltFPwJzsyssGeOwdRO";
        id = 2qTIltFPwJzsyssGeOwdRO;
        images =                 (
                                {
                height = 640;
                url = "https://i.scdn.co/image/ab67616d0000b273b629e669238964a725937c1b";
                width = 640;
            },
                                {
                height = 300;
                url = "https://i.scdn.co/image/ab67616d00001e02b629e669238964a725937c1b";
                width = 300;
            },
                                {
                height = 64;
                url = "https://i.scdn.co/image/ab67616d00004851b629e669238964a725937c1b";
                width = 64;
            }
        );
        name = "Hot Shit (feat. Ye & Lil Durk)";
        "release_date" = "2022-07-01";
        "release_date_precision" = day;
        "total_tracks" = 1;
        type = album;
        uri = "spotify:album:2qTIltFPwJzsyssGeOwdRO";
    },
                {
        "album_type" = single;
        artists =                 (
                                {
                "external_urls" =                         {
                    spotify = "https://open.spotify.com/artist/7CajNmpbOovFoOoasH2HaY";
                };
                href = "https://api.spotify.com/v1/artists/7CajNmpbOovFoOoasH2HaY";
                id = 7CajNmpbOovFoOoasH2HaY;
                name = "Calvin Harris";
                type = artist;
                uri = "spotify:artist:7CajNmpbOovFoOoasH2HaY";
            },
                                {
                "external_urls" =                         {
                    spotify = "https://open.spotify.com/artist/1URnnhqYAYcrqrcwql10ft";
                };
                href = "https://api.spotify.com/v1/artists/1URnnhqYAYcrqrcwql10ft";
                id = 1URnnhqYAYcrqrcwql10ft;
                name = "21 Savage";
                type = artist;
                uri = "spotify:artist:1URnnhqYAYcrqrcwql10ft";
            }
        );
        "available_markets" =                 (
            AD
           
          

        );
        "external_urls" =                 {
            spotify = "https://open.spotify.com/album/1aRWXKL4e4pFg6Z3ObHKKw";
        };
        href = "https://api.spotify.com/v1/albums/1aRWXKL4e4pFg6Z3ObHKKw";
        id = 1aRWXKL4e4pFg6Z3ObHKKw;
        images =                 (
                                {
                height = 640;
                url = "https://i.scdn.co/image/ab67616d0000b2738b8956d4732f8225aeb6129c";
                width = 640;
            },
                                {
                height = 300;
                url = "https://i.scdn.co/image/ab67616d00001e028b8956d4732f8225aeb6129c";
                width = 300;
            },
                                {
                height = 64;
                url = "https://i.scdn.co/image/ab67616d000048518b8956d4732f8225aeb6129c";
                width = 64;
            }
        );
        name = "New Money (feat. 21 Savage)";
        "release_date" = "2022-07-01";
        "release_date_precision" = day;
        "total_tracks" = 1;
        type = album;
        uri = "spotify:album:1aRWXKL4e4pFg6Z3ObHKKw";
    }*/

