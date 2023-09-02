//
//  UserModel.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 31/08/2023.
//

import Foundation

// MARK: - UsersResponse
struct UserModel: Codable {
    let results: [User]
}
// MARK: - Result
struct User: Codable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let dob, registered: Dob
    let phone, cell: String
    let login: Login
    let picture: Picture
    let nat: String
}
//MARK: - Login
struct Login: Codable {
    let uuid: String
}

// MARK: - Dob
struct Dob: Codable {
    let date: String
    let age: Int
}

// MARK: - Location
struct Location: Codable {
    let street: Street
    let city, state, country: String
}
// MARK: - Street
struct Street: Codable {
    let number: Int
    let name: String
}

// MARK: - Name
struct Name: Codable {
    let title, first, last: String
}

// MARK: - Picture
struct Picture: Codable {
    let large, medium, thumbnail: String
}
