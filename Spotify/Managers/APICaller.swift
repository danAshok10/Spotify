//
//  APICaller.swift
//  Spotify
//
//  Created by user212878 on 6/19/22.
//

import Foundation

struct Constant{
    static let baseURL = "https://api.spotify.com/v1"
}
enum APIError: Error {
    case failedToGetData
}
final class APICaller{
    static let shared = APICaller()
    private init(){
        
    }
    //MARK: - Browse
    //to get recomendations
    func getRecomendations(generes: Set<String>,completion: @escaping ((Result<RecomendationResponse,Error>)) -> Void){
        //since we require 5 diff combination of geners in query
        let seeds = generes.joined(separator: ",")
        createRequest(with: URL(string: Constant.baseURL + "/recommendations?limit=45&seed_genres=\(seeds)&market=IT"), type: .GET) { (request) in
            //print(request.url?.absoluteString)
            URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data , error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
               // let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                do{
                let json = try JSONDecoder().decode(RecomendationResponse.self, from: data)
                    completion(.success(json))
                    print("Recomendations:\(json)")
                }catch{
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
                
            }.resume()
        }
    }
    // to get genere recomendations
    func getGenereRecomendations(completion: @escaping ((Result<RecomendedGenereResponse, Error>)) -> Void ){
        createRequest(with: URL(string: Constant.baseURL + "/recommendations/available-genre-seeds"), type: .GET) { (request) in
            URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let json = try JSONDecoder().decode(RecomendedGenereResponse.self, from: data)
                    print("Recomended generes : \(json)")
                    completion(.success(json))
                }catch{
                    completion(.failure(error))
                }
               // let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
               
            }.resume()
        }
        
    }
    // to get featured playlist
    func getFeaturedPlayList(completion: @escaping((Result<FeaturedPlayListResponse,Error>)) -> Void){
        createRequest(with: URL(string: Constant.baseURL + "/browse/featured-playlists?limit=45"), type: .GET) { (request) in
            URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data ,error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
               // let json = try?  JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let json = try? JSONDecoder().decode(FeaturedPlayListResponse.self, from: data)
                if let json = json{
                    completion(.success(json))
                }
                print("New featured Playlist",json)
            }.resume()
        }
    }
    //to fetch new releases
     func getNewReleases(completion: @escaping ((Result<NewReleasesResponse,Error>)) -> Void){
        createRequest(with: URL(string: Constant.baseURL + "/browse/new-releases?limit=45"), type: .GET) { (request) in
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let json = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                   // let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print("New Release \(json)")
                    completion(.success(json))
                }catch{
                    completion(.failure(error.localizedDescription as! Error))
                }
                

            }.resume()
        }
    }
    //MARK: -Search
    public func getSearch(with query:String, completion: @escaping (Result<[SearchResults],Error>) -> Void){
        createRequest(with: URL(string: Constant.baseURL + "/search?type=album,artist,track&limit=5&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"), type: .GET) { (request) in
            
            print(request.url?.absoluteString ?? "none")
            URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data , error == nil else{
                    return
                        completion(.failure(APIError.failedToGetData))
                }
                do{
                    //let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                    let json = try JSONDecoder().decode(SearchResultResponse.self, from: data)
                    print(json)
                    
                    var searchResult: [SearchResults] = []
                    searchResult.append(contentsOf: (json.albums.items.compactMap({SearchResults.album(model: $0)
                    })))
                    searchResult.append(contentsOf: json.artists.items.compactMap({SearchResults.artist(model: $0)}))
                    searchResult.append(contentsOf: json.tracks.items.compactMap({SearchResults.track(model: $0)
                    }))
                    completion(.success(searchResult))
                }catch{
                    completion(.failure(error))
                }
            }.resume()
        }
    }
    //MARK: - Album Detail VC
    public func albumDetail(with album : Album, completion: @escaping (Result<AlbumDeatilResponse,Error>)-> Void ){
        createRequest(with: URL(string: Constant.baseURL + "/albums/" + album.id), type: .GET) { (baseRequest) in
            URLSession.shared.dataTask(with: baseRequest) { (data, _, error) in
                guard let data = data, error == nil else{
                    return
                }
                do{
//                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print("Album detail response:" , json)
                     let json = try? JSONDecoder().decode(AlbumDeatilResponse.self, from: data)
                    completion(.success(json!))
                print("Album detail response:" , json)
                    
                }catch{
                    completion(.failure(error))
                }
                
            }.resume()
        }
    }
    //MARK: - PlayList Detail VC
    public func getPlayListDetails(with playlist: Item,completion: @escaping (Result<PlaylistDetailResponse,Error>) -> Void){
        createRequest(with: URL(string: Constant.baseURL + "/playlists/" + playlist.id), type: .GET) { (request) in
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data , error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
               /* let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    completion(.success(json))
                    print("PlayListDetails:\(json)")*/
                    let json = try JSONDecoder().decode(PlaylistDetailResponse.self, from: data)
                    completion(.success(json))
                    print(json)
                }catch{
                    completion(.failure(error))
                    print(error.localizedDescription)
                    
                }
            }.resume()
        }
    }
    
    //to get current useres playList
    
    public func getCurrentUserPlayList(completion: @escaping (Result<Playlist,Error>) -> Void){
        createRequest(with: URL(string: Constant.baseURL + "/me/playlists"), type: .GET) { (request) in
            URLSession.shared.dataTask(with: request) { (data,_, error) in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do{
                   // let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let json = try JSONDecoder().decode(Playlist.self
                                                        , from: data)
                    completion(.success(json))
                    print(json)
                }catch{
                    completion(.failure(error))
                }
            }.resume()
        }
        
    }
    public func createPlayList(with name: String, completion: @escaping (Bool) -> Void){
        getCurrentUserProfile {[weak self] (result) in
            switch result {
            
            case .success(let user):
                let url = Constant.baseURL + "/users/\(user.id)/playlists"
                self?.createRequest(with: URL(string: url), type: .POST) { [weak self](baseRequest) in
                    var request = baseRequest
                    let json = [
                        "name": name
                    ]
                    request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
                    URLSession.shared.dataTask(with: request) { (data, _, error) in
                        guard let data = data, error == nil else{
                            return
                        }
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            print("Created: \(json)")
                            completion(true)
                        }catch{
                            completion(false)
                        }
                    }.resume()
                }
            case .failure(let error):
                completion(false)
                break
            }
        }
        
    }
    public func addTrackToPlayList(track: AudioTracks,
                                   playList: Playlist,
                                   completion: @escaping (Bool) -> Void){
        let url = URL(string: Constant.baseURL + "/playlists/\(playList.items.first?.id)/tracks")
        createRequest(with: url, type: .POST) { (baseRequest) in
            var request = baseRequest
            let json = [
                "playlists/playlist_id/tracks": "spotify:track:\(track.album.id)"
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data, error == nil else{
                    return
                }
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    if let response = json as? [String: Any], response["snapshot_id"] as? String != nil {
                        completion(true)
                    }
                    completion(true)
                }catch{
                    completion(false)
                }
            }.resume()
        }
    }
    public func removeTrackFtomPlayList(track: AudioTracks,
                                        playList: Playlist,
                                        completion: @escaping (Bool) -> Void){
        
    }
    //MARK: - Profile
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile,Error>) -> Void){
        createRequest(with: URL(string: Constant.baseURL + "/me"), type: .GET) { (baseRequest) in
            URLSession.shared.dataTask(with: baseRequest) { (data, response, error) in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                   let json = try? JSONDecoder().decode(UserProfile.self, from: data)
                    //let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    completion(.success(json!))
                    print("New Token\(json)")
                }catch{
                    completion(.failure(error))
                }
            }.resume()
        }
    }
    //MARK: -Get Several Browse Category
    public func getCategories(completion: @escaping (Result<SearchCategories,Error>) -> Void){
        createRequest(with: URL(string: Constant.baseURL + "/browse/categories?" + "limit=48"), type: .GET) { (request) in
            URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do{
                    //let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let json = try? JSONDecoder().decode(SearchCategories.self, from: data)
                    print("Search Categories",json)
                    if let json = json{
                        completion(.success(json))
                    }
                    
                }catch{
                    completion(.failure(error))
                }
            }.resume()
        }
    }
    //MARK: -Get Browse Category PlayList
    public func getCategoryPlayList(category: SearchItem, completion: @escaping (Result<SearchCategoryPlayList,Error>) -> Void){
        createRequest(with: URL(string: Constant.baseURL + "/browse/categories/\(category.id)/playlists?limit=50"), type: .GET) { (request) in
            URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                   // let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let json = try? JSONDecoder().decode(SearchCategoryPlayList.self, from: data)
                    if let json = json{
                        completion(.success(json))
                        print(json)
                    }
                    
                }catch{
                    completion(.failure(error))
                }
            }.resume()
        }
    }
    
    //MARK: - Demo call to know the audio track response
    
    public func getAudioTrack(completion: @escaping (Result<Any,Error>) ->Void){
         createRequest(with: URL(string: Constant.baseURL + "/tracks/6rqhFgbbKwnb9MLmUQDhG6" ) , type: .GET) { (request) in
            URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data, error == nil else {
                    return
                }
                do{
                    let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    if let json = json{
                        print(json)
                    }
                    
                }catch{
                    completion(.failure(error))
                }
            }.resume()
        }
    }
    
    
    //MARK: - Create Request
    //creating a generic request
    enum HTTPMethod: String{
        case GET
        case POST
    }
    private func createRequest(with url: URL?, type: HTTPMethod , completion: @escaping (URLRequest) -> Void){
        AuthManger.shared.withValidToken { (token) in
            print("Token in APICaller->createRequest : \(token)")
            guard let apiURL = url else{
                return
            }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
}
