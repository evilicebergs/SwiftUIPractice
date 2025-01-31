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

struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height: Double
    
    var work: String = "Worker at Some Job"
    var education: String = "Graduate Degree"

    var aboutMe: String = "This is some data about me to know me better"
    
    var basics: [UserInterest] {
        [
            UserInterest(iconName: "ruler", text: "\(height)"),
            UserInterest(iconName: "graduationcap", text: education),
            UserInterest(iconName: "wineglass", text: "Socially"),
            UserInterest(iconName: "moon.stars.fill", text: "Virgo")
        ]
    }
    
    var interests: [UserInterest] {
        [
            UserInterest(emoji: "👟", text: "Running"),
            UserInterest(emoji: "🏋️‍♀️", text: "Gym"),
            UserInterest(emoji: "🎧", text: "Music"),
            UserInterest(emoji: "🥘", text: "Cooking")
        ]
    }
    
    var images: [String] {
        [
            "https://picsum.photos/500/500",
            "https://picsum.photos/400/400",
            "https://picsum.photos/700/700"
        ]
    }
    
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
            image: Constants.randomImage, height: 189
        )
    }
    
    enum CodingKeys: CodingKey {
        case id
        case firstName
        case lastName
        case age
        case email
        case phone
        case username
        case password
        case image
        case height
    }
    
}
