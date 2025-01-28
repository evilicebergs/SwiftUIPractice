//
//  User.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-01-25.
//

import Foundation

struct UsersArray: Codable {
    let users: [User]
    let total, skip, limit: Int
}

struct User: Codable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    
    static var mock: User {
        User(
            id: 123,
            firstName: "John",
            lastName: "Doe",
            age: 32,
            email: "lohndoe@gmail.com",
            phone: "0946284545",
            username: "johnnyBoy43",
            password: "hellYeah56",
            image: Constants.randomImage
        )
    }
}
