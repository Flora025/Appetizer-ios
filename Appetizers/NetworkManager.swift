//
//  NetworkManager.swift
//  Appetizers
//
//  Created by zhanghan on 5/7/24.
//

import Foundation

final class NetworkManager {
    // singleton
    static let shared = NetworkManager()
    
    static let baseURL = "https://localhost:3000/"
    private let appetizerURL = baseURL + "appetizers"
    
    private init() {}
    
    // get data from json
    func getAppetizers(completed: @escaping (Result<[Appetizer], APError>) -> Void) {
        guard let url = URL(string: appetizerURL) else {
            // check if the url works
            completed(.failure(.invalidURL))
            return
        }
        
        // create a network call
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            // do some error handling
            guard let _ = error else {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                // decode the json
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(AppetizerResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
    
    // download image from url
}
