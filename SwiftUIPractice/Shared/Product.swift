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
    let brand: String?
    let weight: Int
    let images: [String]
    let thumbnail: String
    let category: String
    
    var image: String {
        images.first ?? Constants.randomImage
    }
    
    static var mock: Product {
        Product(
            id: 123,
            title: "Example product title",
            description: "Description of the mock product",
            price: 1200.0,
            discountPercentage: 3.5,
            rating: 5.0,
            stock: 1000,
            brand: "Apple",
            weight: 2,
            images: [Constants.randomImage],
            thumbnail: Constants.randomImage,
            category: "Electronic Devices"
        )
    }
    
}

struct ProductRow: Identifiable {
    let title: String
    let products: [Product]
    let id = UUID().uuidString
}
