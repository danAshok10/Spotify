//
//  AlbumDeatilResponse.swift
//  Spotify
//
//  Created by user212878 on 7/25/22.
//

import Foundation
struct AlbumDeatilResponse: Codable{
    var album: Album?
    let album_type: String
    let artists: [Artist]
    let external_urls: [String: String]
    let images: [Image]
    let name: String
    let release_date: String
    let tracks: AlbumTracks
}
struct AlbumTracks: Codable{
    let items: [AlbumTrack]
}
struct AlbumTrack: Codable {
    var album: Album?
    let artists: [Artist]
    let disc_number: Int
    let duration_ms: Int
    let external_urls: [String: String]
    let id: String
    let name: String
    let track_number: Int
}


//Album detail response: {
//    "album_type" = album;
//    artists =     (
//                {
//            "external_urls" =             {
//                spotify = "https://open.spotify.com/artist/0CDUUM6KNRvgBFYIbWxJwV";
//            };
//            href = "https://api.spotify.com/v1/artists/0CDUUM6KNRvgBFYIbWxJwV";
//            id = 0CDUUM6KNRvgBFYIbWxJwV;
//            name = Dawes;
//            type = artist;
//            uri = "spotify:artist:0CDUUM6KNRvgBFYIbWxJwV";
//        }
//    );
//    "available_markets" =     (
//        AD,
//        AE
//    );
//    copyrights =     (
//                {
//            text = "\U00a9 2022 HUB Records II, LLC., Under exclusive license to Rounder Records. Distributed by Concord.";
//            type = C;
//        },
//                {
//            text = "\U2117 2022 HUB Records II, LLC., Under exclusive license to Rounder Records. Distributed by Concord.";
//            type = P;
//        }
//    );
//    "external_ids" =     {
//        upc = 00888072416048;
//    };
//    "external_urls" =     {
//        spotify = "https://open.spotify.com/album/24FkcvXRLoG17447domdkg";
//    };
//    genres =     (
//    );
//    href = "https://api.spotify.com/v1/albums/24FkcvXRLoG17447domdkg";
//    id = 24FkcvXRLoG17447domdkg;
//    images =     (
//                {
//            height = 640;
//            url = "https://i.scdn.co/image/ab67616d0000b27373aee5a2622de90bd9d814dd";
//            width = 640;
//        },
//                {
//            height = 300;
//            url = "https://i.scdn.co/image/ab67616d00001e0273aee5a2622de90bd9d814dd";
//            width = 300;
//        },
//                {
//            height = 64;
//            url = "https://i.scdn.co/image/ab67616d0000485173aee5a2622de90bd9d814dd";
//            width = 64;
//        }
//    );
//    label = Rounder;
//    name = "Misadventures Of Doomscroller";
//    popularity = 30;
//    "release_date" = "2022-07-22";
//    "release_date_precision" = day;
//    "total_tracks" = 7;
//    tracks =     {
//        href = "https://api.spotify.com/v1/albums/24FkcvXRLoG17447domdkg/tracks?offset=0&limit=50&locale=en-us";
//        items =         (
//                        {
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/0CDUUM6KNRvgBFYIbWxJwV";
//                        };
//                        href = "https://api.spotify.com/v1/artists/0CDUUM6KNRvgBFYIbWxJwV";
//                        id = 0CDUUM6KNRvgBFYIbWxJwV;
//                        name = Dawes;
//                        type = artist;
//                        uri = "spotify:artist:0CDUUM6KNRvgBFYIbWxJwV";
//                    }
//                );
//                "available_markets" =                 (
//                    AD,
//                    AE
//                );
//                "disc_number" = 1;
//                "duration_ms" = 566986;
//                explicit = 0;
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/track/0T4thAUeigWf0gwoVIA2vN";
//                };
//                href = "https://api.spotify.com/v1/tracks/0T4thAUeigWf0gwoVIA2vN";
//                id = 0T4thAUeigWf0gwoVIA2vN;
//                "is_local" = 0;
//                name = "Someone Else\U2019s Cafe / Doomscroller Tries To Relax";
//                "preview_url" = "<null>";
//                "track_number" = 1;
//                type = track;
//                uri = "spotify:track:0T4thAUeigWf0gwoVIA2vN";
//            },
//                        {
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/0CDUUM6KNRvgBFYIbWxJwV";
//                        };
//                        href = "https://api.spotify.com/v1/artists/0CDUUM6KNRvgBFYIbWxJwV";
//                        id = 0CDUUM6KNRvgBFYIbWxJwV;
//                        name = Dawes;
//                        type = artist;
//                        uri = "spotify:artist:0CDUUM6KNRvgBFYIbWxJwV";
//                    }
//                );
//                "available_markets" =                 (
//                    AD,
//                    AE
//                );
//                "disc_number" = 1;
//                "duration_ms" = 330653;
//                explicit = 0;
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/track/4tP7SjS89hevcazxmqshtm";
//                };
//                href = "https://api.spotify.com/v1/tracks/4tP7SjS89hevcazxmqshtm";
//                id = 4tP7SjS89hevcazxmqshtm;
//                "is_local" = 0;
//                name = "Comes In Waves";
//                "preview_url" = "<null>";
//                "track_number" = 2;
//                type = track;
//                uri = "spotify:track:4tP7SjS89hevcazxmqshtm";
//            },
//                        {
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/0CDUUM6KNRvgBFYIbWxJwV";
//                        };
//                        href = "https://api.spotify.com/v1/artists/0CDUUM6KNRvgBFYIbWxJwV";
//                        id = 0CDUUM6KNRvgBFYIbWxJwV;
//                        name = Dawes;
//                        type = artist;
//                        uri = "spotify:artist:0CDUUM6KNRvgBFYIbWxJwV";
//                    }
//                );
//                "available_markets" =                 (
//                    AD,
//                    AE
//                );
//                "disc_number" = 1;
//                "duration_ms" = 523866;
//                explicit = 0;
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/track/1fzH5lasneLAsYt9qenUSh";
//                };
//                href = "https://api.spotify.com/v1/tracks/1fzH5lasneLAsYt9qenUSh";
//                id = 1fzH5lasneLAsYt9qenUSh;
//                "is_local" = 0;
//                name = "Everything Is Permanent";
//                "preview_url" = "<null>";
//                "track_number" = 3;
//                type = track;
//                uri = "spotify:track:1fzH5lasneLAsYt9qenUSh";
//            },
//                        {
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/0CDUUM6KNRvgBFYIbWxJwV";
//                        };
//                        href = "https://api.spotify.com/v1/artists/0CDUUM6KNRvgBFYIbWxJwV";
//                        id = 0CDUUM6KNRvgBFYIbWxJwV;
//                        name = Dawes;
//                        type = artist;
//                        uri = "spotify:artist:0CDUUM6KNRvgBFYIbWxJwV";
//                    }
//                );
//                "available_markets" =                 (
//                    AD,
//                    AE
//                );
//                "disc_number" = 1;
//                "duration_ms" = 379640;
//                explicit = 0;
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/track/6pyrBZHMN5sXTabKZVkaxd";
//                };
//                href = "https://api.spotify.com/v1/tracks/6pyrBZHMN5sXTabKZVkaxd";
//                id = 6pyrBZHMN5sXTabKZVkaxd;
//                "is_local" = 0;
//                name = "Ghost In The Machine";
//                "preview_url" = "<null>";
//                "track_number" = 4;
//                type = track;
//                uri = "spotify:track:6pyrBZHMN5sXTabKZVkaxd";
//            },
//                        {
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/0CDUUM6KNRvgBFYIbWxJwV";
//                        };
//                        href = "https://api.spotify.com/v1/artists/0CDUUM6KNRvgBFYIbWxJwV";
//                        id = 0CDUUM6KNRvgBFYIbWxJwV;
//                        name = Dawes;
//                        type = artist;
//                        uri = "spotify:artist:0CDUUM6KNRvgBFYIbWxJwV";
//                    }
//                );
//                "available_markets" =                 (
//                    AD,
//                    AE
//                );
//                "disc_number" = 1;
//                "duration_ms" = 324146;
//                explicit = 0;
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/track/2F8Q1YdmN5DIK2r6jMeMYJ";
//                };
//                href = "https://api.spotify.com/v1/tracks/2F8Q1YdmN5DIK2r6jMeMYJ";
//                id = 2F8Q1YdmN5DIK2r6jMeMYJ;
//                "is_local" = 0;
//                name = "Joke In There Somewhere";
//                "preview_url" = "<null>";
//                "track_number" = 5;
//                type = track;
//                uri = "spotify:track:2F8Q1YdmN5DIK2r6jMeMYJ";
//            },
//                        {
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/0CDUUM6KNRvgBFYIbWxJwV";
//                        };
//                        href = "https://api.spotify.com/v1/artists/0CDUUM6KNRvgBFYIbWxJwV";
//                        id = 0CDUUM6KNRvgBFYIbWxJwV;
//                        name = Dawes;
//                        type = artist;
//                        uri = "spotify:artist:0CDUUM6KNRvgBFYIbWxJwV";
//                    }
//                );
//                "available_markets" =                 (
//                    AD,
//                    AE,
//                    AG,
//                    ZW
//                );
//                "disc_number" = 1;
//                "duration_ms" = 97986;
//                explicit = 0;
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/track/0fhvVpJZVMkb39Xue7EuCd";
//                };
//                href = "https://api.spotify.com/v1/tracks/0fhvVpJZVMkb39Xue7EuCd";
//                id = 0fhvVpJZVMkb39Xue7EuCd;
//                "is_local" = 0;
//                name = "Joke In There Somewhere - Outro";
//                "preview_url" = "<null>";
//                "track_number" = 6;
//                type = track;
//                uri = "spotify:track:0fhvVpJZVMkb39Xue7EuCd";
//            },
//                        {
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/0CDUUM6KNRvgBFYIbWxJwV";
//                        };
//                        href = "https://api.spotify.com/v1/artists/0CDUUM6KNRvgBFYIbWxJwV";
//                        id = 0CDUUM6KNRvgBFYIbWxJwV;
//                        name = Dawes;
//                        type = artist;
//                        uri = "spotify:artist:0CDUUM6KNRvgBFYIbWxJwV";
//                    }
//                );
//                "available_markets" =                 (
//                     ZM,
//                    ZW
//                );
//                "disc_number" = 1;
//                "duration_ms" = 543746;
//                explicit = 0;
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/track/3G9BEBFS79VKDD47RFqRN1";
//                };
//                href = "https://api.spotify.com/v1/tracks/3G9BEBFS79VKDD47RFqRN1";
//                id = 3G9BEBFS79VKDD47RFqRN1;
//                "is_local" = 0;
//                name = "Sound That No One Made / Doomscroller Sunrise";
//                "preview_url" = "<null>";
//                "track_number" = 7;
//                type = track;
//                uri = "spotify:track:3G9BEBFS79VKDD47RFqRN1";
//            }
//        );
//        limit = 50;
//        next = "<null>";
//        offset = 0;
//        previous = "<null>";
//        total = 7;
//    };
//    type = album;
//    uri = "spotify:album:24FkcvXRLoG17447domdkg";
//}
//
