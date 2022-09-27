//
//  RecomendationResponse.swift
//  Spotify
//
//  Created by user212878 on 7/13/22.
//

import Foundation
struct RecomendationResponse:Codable{
   // let seeds: [Seed]
    let tracks:[AudioTracks]
}
/*struct Seed: Codable {
    let id: String
    let initialPoolSize: Int
    let type: String
}*/


/*Optional({
    seeds =     (
                {
            afterFilteringSize = 251;
            afterRelinkingSize = 251;
            href = "<null>";
            id = songwriter;
            initialPoolSize = 482;
            type = GENRE;
        },
                {
            afterFilteringSize = 100;
            afterRelinkingSize = 100;
            href = "<null>";
            id = club;
            initialPoolSize = 100;
            type = GENRE;
        },
                {
            afterFilteringSize = 127;
            afterRelinkingSize = 127;
            href = "<null>";
            id = kids;
            initialPoolSize = 127;
            type = GENRE;
        },
                {
            afterFilteringSize = 251;
            afterRelinkingSize = 251;
            href = "<null>";
            id = rock;
            initialPoolSize = 995;
            type = GENRE;
        },
                {
            afterFilteringSize = 251;
            afterRelinkingSize = 251;
            href = "<null>";
            id = anime;
            initialPoolSize = 2526;
            type = GENRE;
        }
    );
    tracks =     (
                {
            album =             {
                "album_type" = ALBUM;
                artists =                 (
                                        {
                        "external_urls" =                         {
                            spotify = "https://open.spotify.com/artist/2HLk2BpKlxhSErbR7ywV5j";
                        };
                        href = "https://api.spotify.com/v1/artists/2HLk2BpKlxhSErbR7ywV5j";
                        id = 2HLk2BpKlxhSErbR7ywV5j;
                        name = "Baby Genius";
                        type = artist;
                        uri = "spotify:artist:2HLk2BpKlxhSErbR7ywV5j";
                    }
                );
                "available_markets" =                 (
                );
                "external_urls" =                 {
                    spotify = "https://open.spotify.com/album/5mZ7VLdRSkX1ibRs5nB0tf";
                };
                href = "https://api.spotify.com/v1/albums/5mZ7VLdRSkX1ibRs5nB0tf";
                id = 5mZ7VLdRSkX1ibRs5nB0tf;
                images =                 (
                                        {
                        height = 640;
                        url = "https://i.scdn.co/image/ab67616d0000b2730b78fbd5ce8f4fab2e21b6d7";
                        width = 640;
                    },
                                        {
                        height = 300;
                        url = "https://i.scdn.co/image/ab67616d00001e020b78fbd5ce8f4fab2e21b6d7";
                        width = 300;
                    },
                                        {
                        height = 64;
                        url = "https://i.scdn.co/image/ab67616d000048510b78fbd5ce8f4fab2e21b6d7";
                        width = 64;
                    }
                );
                name = "50 Favorite Sing-a-Longs, Vol 1";
                "release_date" = "2012-03-13";
                "release_date_precision" = day;
                "total_tracks" = 50;
                type = album;
                uri = "spotify:album:5mZ7VLdRSkX1ibRs5nB0tf";
            };
            artists =             (
                                {
                    "external_urls" =                     {
                        spotify = "https://open.spotify.com/artist/2HLk2BpKlxhSErbR7ywV5j";
                    };
                    href = "https://api.spotify.com/v1/artists/2HLk2BpKlxhSErbR7ywV5j";
                    id = 2HLk2BpKlxhSErbR7ywV5j;
                    name = "Baby Genius";
                    type = artist;
                    uri = "spotify:artist:2HLk2BpKlxhSErbR7ywV5j";
                }
            );
            "available_markets" =             (
            );
            "disc_number" = 1;
            "duration_ms" = 131133;
            explicit = 0;
            "external_ids" =             {
                isrc = USA560887897;
            };
            "external_urls" =             {
                spotify = "https://open.spotify.com/track/6ldmAg4gi29jwvviS2ir4b";
            };
            href = "https://api.spotify.com/v1/tracks/6ldmAg4gi29jwvviS2ir4b";
            id = 6ldmAg4gi29jwvviS2ir4b;
            "is_local" = 0;
            name = "Old McDonald";
            popularity = 0;
            "preview_url" = "<null>";
            "track_number" = 13;
            type = track;
            uri = "spotify:track:6ldmAg4gi29jwvviS2ir4b";
        },
                {
            album =             {
                "album_type" = COMPILATION;
                artists =                 (
                                        {
                        "external_urls" =                         {
                            spotify = "https://open.spotify.com/artist/0LyfQWJT6nXafLPZqxe9Of";
                        };
                        href = "https://api.spotify.com/v1/artists/0LyfQWJT6nXafLPZqxe9Of";
                        id = 0LyfQWJT6nXafLPZqxe9Of;
                        name = "Various Artists";
                        type = artist;
                        uri = "spotify:artist:0LyfQWJT6nXafLPZqxe9Of";
                    }
                );
                "available_markets" =                 (
                    JP
                );
                "external_urls" =                 {
                    spotify = "https://open.spotify.com/album/2b4jAeJMxh7URjokxy8zil";
                };
                href = "https://api.spotify.com/v1/albums/2b4jAeJMxh7URjokxy8zil";
                id = 2b4jAeJMxh7URjokxy8zil;
                images =                 (
                                        {
                        height = 640;
                        url = "https://i.scdn.co/image/ab67616d0000b273b7b300b2958145319d4d7ed2";
                        width = 640;
                    },
                                        {
                        height = 300;
                        url = "https://i.scdn.co/image/ab67616d00001e02b7b300b2958145319d4d7ed2";
                        width = 300;
                    },
                                        {
                        height = 64;
                        url = "https://i.scdn.co/image/ab67616d00004851b7b300b2958145319d4d7ed2";
                        width = 64;
                    }
                );
                name = "\U9019\U3044\U3088\U308c!\U30cb\U30e3\U30eb\U5b50\U3055\U3093F\U30aa\U30fc\U30d7\U30cb\U30f3\U30b0&\U30a8\U30f3\U30c7\U30a3\U30f3\U30b0\U300e\U9019\U3044\U3088\U308cOnce Nyagain/\U304d\U3063\U3068\U30a8\U30f3\U30b2\U30fc\U30b8\U300f";
                "release_date" = "2015-05-08";
                "release_date_precision" = day;
                "total_tracks" = 4;
                type = album;
                uri = "spotify:album:2b4jAeJMxh7URjokxy8zil";
            };
            artists =             (
                                {
                    "external_urls" =                     {
                        spotify = "https://open.spotify.com/artist/1qwO6Qzw4TAoAdePpNi7vV";
                    };
                    href = "https://api.spotify.com/v1/artists/1qwO6Qzw4TAoAdePpNi7vV";
                    id = 1qwO6Qzw4TAoAdePpNi7vV;
                    name = "Ushirokarahaiyoritai G";
                    type = artist;
                    uri = "spotify:artist:1qwO6Qzw4TAoAdePpNi7vV";
                }
            );
            "available_markets" =             (
                JP
            );
            "disc_number" = 1;
            "duration_ms" = 232573;
            explicit = 0;
            "external_ids" =             {
                isrc = JPB601501586;
            };
            "external_urls" =             {
                spotify = "https://open.spotify.com/track/0lp0B2RhwMgSIyrwct9Yfs";
            };
            href = "https://api.spotify.com/v1/tracks/0lp0B2RhwMgSIyrwct9Yfs";
            id = 0lp0B2RhwMgSIyrwct9Yfs;
            "is_local" = 0;
            name = "\U9019\U3044\U3088\U308cOnce Nyagain";
            popularity = 24;
            "preview_url" = "<null>";
            "track_number" = 1;
            type = track;
            uri = "spotify:track:0lp0B2RhwMgSIyrwct9Yfs";
        }
    );
})*/
