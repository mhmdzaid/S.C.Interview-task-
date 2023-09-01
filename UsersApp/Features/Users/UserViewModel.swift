//
//  UserViewModel.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 31/08/2023.
//

import Foundation

public class UserViewModel {
    let name: String
    let email: String
    let pic: URL?
    
    init(user: User) {
        let userName = user.name
        name = userName.title + ". " + userName.first + " " + userName.last
        email = user.email
        pic = URL(string: user.picture.large)
    }
}
