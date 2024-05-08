//
//  NetworkManager.swift
//  Appetizers
//
//  Created by zhanghan on 5/7/24.
//

import Foundation
import UIKit

final class NetworkManager {
    // singleton
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
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
            if let _ = error {
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
    func downloadImage(fromURLString urlString: String, completed: @escaping (UIImage?) -> Void) {
        // check cache
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        // if not in cache
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        // make network call
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey) // save in cache
            completed(image) // success
        }
        
        task.resume()
    }
}
