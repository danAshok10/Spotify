//
//  AuthManager.swift
//  Spotify
//
//  Created by user212878 on 6/19/22.
//

import Foundation
final class AuthManger{
    var refreshingToken = false
    static let shared = AuthManger()
    let defaults = UserDefaults.standard
    struct Constants{
        static let clientID = "4e99ee0a70ec4bfcaf756f0a202bdb97"
        static let clientSecret = "243074d27eaf454ebf95fc34572c570d"
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
    }
    public var signInURL: URL? {
        let scope = "user-read-private,user-read-email"
        let base = "https://accounts.spotify.com/authorize"
        let redirectURI = "https://www.whatsapp.com/"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(scope)&redirect_uri=\(redirectURI)&show_dialog=TRUE"
        return URL(string: string)
    }
    private init(){}
    var isSignedIn: Bool{
        return accessToken != nil
    }
    private var accessToken: String?{
        return defaults.string(forKey: "access_token")
    }
    private var refreshToken: String?{
        return defaults.string(forKey: "refresh_token")
    }
    private var tokenExpirationDate: Date?{
        return defaults.object(forKey: "expires_in") as? Date
    }
    private var shouldRefreshToken: Bool{
        guard let expirationTime = tokenExpirationDate else{
            return false
        }
        //we have set a buffer time of two minutes actual expiration time is 3600 sec
        let twoMinutes : TimeInterval = 120
        let currentDate = Date()
            return currentDate.addingTimeInterval(twoMinutes) >= expirationTime

    }
    
    //MARK: - Exchange Code for Token
    public func exchangeCodeForToken(code: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: Constants.tokenAPIURL) else{
            return
        }
         var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: "https://www.whatsapp.com/")
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constants.clientID + ":" + Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else{
            print("Failure in base 64")
            completion(false)
            return
            
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else{
                completion(false)
                return
            }
           do{
            let json = try JSONDecoder().decode(AuthResponse.self, from: data)
              
                print("Sucess: \(json)")
            self.cacheToken(result: json)
            completion(true)
            }
            catch{
                print("Error:\(error.localizedDescription)")
                completion(false)
            }
      /*  let json = try? JSONEncoder().encode(data)
            if let json = json{
                completion(true)
                let jsonObj = String(data:json, encoding: .utf8)
                print("Sucess \(jsonObj!)")
            }else{
                print(error?.localizedDescription)
                completion(false)
            }*/
        }.resume()
    }
    private var onRefreshBlocks = [((String) -> Void)]()
    
    
    //to check whether its a valid token for every API call
    public func withValidToken(completion: @escaping (String) -> Void){
        guard !refreshingToken else{
            onRefreshBlocks.append(completion)
            return
        }
        if shouldRefreshToken{
             refreshAccessToken { [weak self] (sucess) in
                if let token = self?.accessToken, sucess{
                    completion(token)
                    print("Token: \(token)")
                }
            }
        }else if let token = self.accessToken{
            completion(token)
            print("Token: \(token)")
        }
    }
    public func refreshAccessToken(completion: ((Bool) -> Void)?){
        guard !refreshingToken else{
            return
        }
       guard shouldRefreshToken else{
            completion?(true)
            return
        }
        guard let refreshToken = self.refreshToken else {
            return
        }
        
        //Api call to refresh the token
        
        refreshingToken = true
        guard let url = URL(string: Constants.tokenAPIURL) else{
            return
        }
       var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: self.refreshToken)
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constants.clientID + ":" + Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else{
            print("Failure in base 64")
            completion?(false)
            return
            
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            self.refreshingToken = false
            guard let data = data, error == nil else{
                completion?(false)
                return
            }
           do{
            let json = try JSONDecoder().decode(AuthResponse.self, from: data)
             
            self.onRefreshBlocks.forEach {$0(json.access_token)}
            self.onRefreshBlocks.removeAll()
                print("Sucess in refreshing token: \(json)")
            self.cacheToken(result: json)
            completion?(true)
            }
            catch{
                print("Error:\(error.localizedDescription)")
                completion?(false)
            }
      /*  let json = try? JSONEncoder().encode(data)
            if let json = json{
                completion(true)
                let jsonObj = String(data:json, encoding: .utf8)
                print("Sucess \(jsonObj!)")
            }else{
                print(error?.localizedDescription)
                completion(false)
            }*/
        }.resume()

        
    }
    
    //MARK: -UserDefaults
    
    public func cacheToken(result: AuthResponse) {
        defaults.setValue(result.access_token, forKey: "access_token")
        if let refreshToken = result.refresh_token{
        defaults.setValue(refreshToken, forKey: "refresh_token")
        }
        defaults.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expires_in")
    }
    
    public func signOut(completion: (Bool) ->  Void){
        defaults.setValue(nil, forKey: "access_token")
        
        defaults.setValue(nil, forKey: "refresh_token")
        
        defaults.setValue(nil, forKey: "expires_in")
        completion(true)
    }
}
