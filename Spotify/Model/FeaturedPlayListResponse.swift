//
//  FeaturedPlayListResponse.swift
//  Spotify
//
//  Created by user212878 on 7/8/22.
//

import Foundation
struct FeaturedPlayListResponse: Codable{
    let message: String
let playlists: Playlist
    
}

/*message = "Editor's picks";
 playlists =     {
     href = "https://api.spotify.com/v1/browse/featured-playlists?timestamp=2022-07-08T12%3A23%3A49&offset=0&limit=2";
     items =         (
                     {
             collaborative = 0;
             description = "The very best in new music from around the world. Cover: The 1975";
             "external_urls" =                 {
                 spotify = "https://open.spotify.com/playlist/37i9dQZF1DWXJfnUiYjUKT";
             };
             href = "https://api.spotify.com/v1/playlists/37i9dQZF1DWXJfnUiYjUKT";
             id = 37i9dQZF1DWXJfnUiYjUKT;
             images =                 (
                                     {
                     height = "<null>";
                     url = "https://i.scdn.co/image/ab67706f0000000350c12503a1f3aa999899d772";
                     width = "<null>";
                 }
             );
             name = "New Music Friday";
             owner =                 {
                 "display_name" = Spotify;
                 "external_urls" =                     {
                     spotify = "https://open.spotify.com/user/spotify";
                 };
                 href = "https://api.spotify.com/v1/users/spotify";
                 id = spotify;
                 type = user;
                 uri = "spotify:user:spotify";
             };
             "primary_color" = "<null>";
             public = "<null>";
             "snapshot_id" = MTY1NzIzODQwMCwwMDAwMDM4MTAwMDAwMTgxZGIxYjJjZDIwMDAwMDE4MWRhZWRjOTMy;
             tracks =                 {
                 href = "https://api.spotify.com/v1/playlists/37i9dQZF1DWXJfnUiYjUKT/tracks";
                 total = 95;
             };
             type = playlist;
             uri = "spotify:playlist:37i9dQZF1DWXJfnUiYjUKT";
         },
                     {
             collaborative = 0;
             description = "Music from Roddy Ricch, Fivio Foreign and Yo Gotti's CMG collective.";
             "external_urls" =                 {
                 spotify = "https://open.spotify.com/playlist/37i9dQZF1DX0XUsuxWHRQd";
             };
             href = "https://api.spotify.com/v1/playlists/37i9dQZF1DX0XUsuxWHRQd";
             id = 37i9dQZF1DX0XUsuxWHRQd;
             images =                 (
                                     {
                     height = "<null>";
                     url = "https://i.scdn.co/image/ab67706f00000003133111d0d4e149e7d871f7da";
                     width = "<null>";
                 }
             );
             name = RapCaviar;
             owner =                 {
                 "display_name" = Spotify;
                 "external_urls" =                     {
                     spotify = "https://open.spotify.com/user/spotify";
                 };
                 href = "https://api.spotify.com/v1/users/spotify";
                 id = spotify;
                 type = user;
                 uri = "spotify:user:spotify";
             };
             "primary_color" = "<null>";
             public = "<null>";
             "snapshot_id" = MTY1NzI1Mjg2MCwwMDAwMDY3MzAwMDAwMTgxZGJmN2QxMmUwMDAwMDE4MWQ5OTYzYzgy;
             tracks =                 {
                 href = "https://api.spotify.com/v1/playlists/37i9dQZF1DX0XUsuxWHRQd/tracks";
                 total = 50;
             };
             type = playlist;
             uri = "spotify:playlist:37i9dQZF1DX0XUsuxWHRQd";
         }
     );
     limit = 2;
     next = "https://api.spotify.com/v1/browse/featured-playlists?timestamp=2022-07-08T12%3A23%3A49&offset=2&limit=2";
     offset = 0;
     previous = "<null>";
     total = 12;
 };
}))*/
