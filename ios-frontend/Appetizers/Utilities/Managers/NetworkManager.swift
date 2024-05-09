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
    
    static let baseURL = "http://127.0.0.1:5000/"
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
    
    func addOrderItem(_ appetizer: Appetizer) {
        guard let url = URL(string: "http://your-api-url/api/orderitem") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // init object
        let newOrderItem: [String: Any] = [
            "name": appetizer.name,
            "description": appetizer.description,
            "price": appetizer.price,
            "imageURL": appetizer.imageURL,
            "calories": appetizer.calories,
            "protein": appetizer.protein,
            "carbs": appetizer.carbs
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: newOrderItem, options: [])
        } catch {
            print("Error encoding order item:", error)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error adding order item:", error)
                return
            }
            
            // deal with response
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                print("Order item added successfully")
            } else {
                print("Failed to add order item")
            }
        }
        
        task.resume()
    }

    
    func deleteOrderItem(itemID: Int) {
        let urlString = "http://your-api-url/api/orderitem/\(itemID)"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error deleting order item:", error)
                return
            }
            
            // deal with response
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Order item deleted successfully")
            } else {
                print("Failed to delete order item")
            }
        }
        
        task.resume()
    }
}
