//
//  DataModel.swift
//  NCXlenavolkovs
//
//  Created by Elena Volkova on 26/03/24.
//

import Foundation

class SpotifyManager: ObservableObject {
    
    var spotifyAccessToken = ""
    let spotifyClientID = "478439e2403849a794ef52b55dc84622"
    let spotifyClientSecret = "8b9089db098b4a16b14a79ecf952ba48"
    
    @Published var items = [Item]()
    
    
//    func getAccessToken() async -> String? {
//        let tokenEndpoint = "https://accounts.spotify.com/api/token"
//        
//        var request = URLRequest(url: URL(string: tokenEndpoint)!)
//        request.httpMethod = "POST"
//        
//        let bodyData = "grant_type=client_credentials&client_id=\(spotifyClientID)&client_secret=\(spotifyClientSecret)"
//        request.httpBody = bodyData.data(using: .utf8)
//        
//        // Set headers
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        
//        do {
//            let (data, _) = try await URLSession.shared.data(for: request)
//            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//               let accessToken = json["access_token"] as? String {
//                return accessToken
//            } else {
//                print("Access token not found in response.")
//                return nil
//            }
//        } catch {
//            print("Error fetching access token: \(error.localizedDescription)")
//            return nil
//        }
//    }
//    
//    func fetchSpotifyData() async {
//
//        //Creating the URL
//        guard let url = URL(string: "https://api.spotify.com/v1/search?type=track&query=bad bunny") else {
//            print("Invalid URL")
//            return
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        
//        // Set headers
//        //        getAccessToken()
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue(spotifyAccessToken, forHTTPHeaderField: "Authentication")
//        
//        do {
//            let (data, _) = try await URLSession.shared.data(for: request)
//            if let responseString = String(data: data, encoding: .utf8) {
//                   print("Response as string:", responseString)
//                   // Now you can use the responseString as needed
//               } else {
//                   print("Error converting data to string")
//               }
//            print("Data received")
//            print("at: \(self.spotifyAccessToken)")
//            print(data.count)
//            
//            //Decoding the result
//            if let decodedResponse = try? JSONDecoder().decode(SpotifyResponse.self, from: data) {
//                items = decodedResponse.tracks.items
//                print("Data decoded")
//                print(items.count)
//                print(items)
//            }
//        } catch {
//            print("Invalid data")
//        }
//    }
    
    func getAccessToken() async -> String? {
            let tokenEndpoint = "https://accounts.spotify.com/api/token"
            
            var request = URLRequest(url: URL(string: tokenEndpoint)!)
            request.httpMethod = "POST"
            
            let bodyData = "grant_type=client_credentials&client_id=\(spotifyClientID)&client_secret=\(spotifyClientSecret)"
            request.httpBody = bodyData.data(using: .utf8)
            
            // Set headers
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let accessToken = json["access_token"] as? String {
                    print(accessToken)
                    return accessToken
                } else {
                    print("Access token not found in response.")
                    return nil
                }
            } catch {
                print("Error fetching access token: \(error.localizedDescription)")
                return nil
            }
        }
        
    func fetchSpotifyData(searchText: String) async {
            guard let accessToken = await getAccessToken() else {
                print("Failed to get access token.")
                return
            }
            
            self.spotifyAccessToken = accessToken
            
            guard let url = URL(string: "https://api.spotify.com/v1/search?type=track&query=\(searchText)") else {
                print("Invalid URL")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            // Set headers with access token
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(self.spotifyAccessToken)", forHTTPHeaderField: "Authorization")
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                // Handle data response as needed
                if let responseString = String(data: data, encoding: .utf8) {
//                                   print("Response as string:", responseString)
                                   // Now you can use the responseString as needed
                               } else {
                                   print("Error converting data to string")
                               }
                //Decoding the result
                if let decodedResponse = try? JSONDecoder().decode(SpotifyResponse.self, from: data) {
                    items = decodedResponse.tracks.items.sorted { $0.popularity > $1.popularity }
                    print("Data decoded")
                    print(items.count)
                    print(items)
                }
            } catch {
                print("Error fetching Spotify data:", error.localizedDescription)
            }
        }
}

//func fetchData() {
//    let tokenEndpoint = "https://accounts.spotify.com/api/token"
//    
//    var request = URLRequest(url: URL(string: tokenEndpoint)!)
//    request.httpMethod = "GET"
//    
//    let bodyData = "grant_type=client_credentials&client_id=\(spotifyClientID)&client_secret=\(spotifyClientSecret)"
//    request.httpBody = bodyData.data(using: .utf8)
//    
//    // Set headers
//    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//    
//    let session = URLSession.shared
//}


