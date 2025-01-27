//
//  Product.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-01-25.
//

import Foundation

struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Codable, Identifiable {
    let id: Int
    let title, description: String
    let price, discountPercentage, rating: Double
    let stock: Int
    let tags: [String]
    let brand: String?
    let weight: Int
    let images: [String]
    let thumbnail: String
    let category: String?
    
    var image: String {
        images.first ?? Constants.randomImage
    }
    
}

struct ProductRow: Identifiable {
    let title: String
    let products: [Product]
    let id = UUID().uuidString
}
