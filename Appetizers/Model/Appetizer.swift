//
//  Appetizer.swift
//  Appetizers
//
//  Created by zhanghan on 5/7/24.
//

import Foundation

struct Appetizer: Decodable, Identifiable {
    let id: Int // unique identifier
    let name: String
    let description: String
    let price: Double
    let imageURL: String
    
    // nutritional info
    let calories: Int
    let protein: Int
    let carbs: Int
}

// helper struct for http request
struct AppetizerResponse: Decodable {
    let request: [Appetizer]
}

struct MockData {
    static let sampleAppetizer = Appetizer(
        id: 0001, name: "Test Appetizer",
        description: "This is the description", price: 9.99,
        imageURL: "", calories: 99,
        protein: 101, carbs: 999)
    
    static let appetizers = [sampleAppetizer, sampleAppetizer, sampleAppetizer, sampleAppetizer]
    
    static let orderItem1 = Appetizer(
        id: 0001, name: "Order Item 1",
        description: "This is the description", price: 9.99,
        imageURL: "", calories: 99,
        protein: 101, carbs: 999)
    
    static let orderItem2 = Appetizer(
        id: 0001, name: "Order Item 2",
        description: "This is the description", price: 9.99,
        imageURL: "", calories: 99,
        protein: 101, carbs: 999)
    
    static let orderItem3 = Appetizer(
        id: 0001, name: "Order Item 3",
        description: "This is the description", price: 9.99,
        imageURL: "", calories: 99,
        protein: 101, carbs: 999)
    
    static let orderItems = [orderItem1, orderItem2, orderItem3]
}
