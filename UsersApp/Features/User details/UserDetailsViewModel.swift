//
//  UserDetailsViewModel.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 01/09/2023.
//

import Foundation

protocol UserDetailsViewModelProtocol {
    var userImageUrl: URL? { get }
    var username: String { get }
    var email: String { get }
    var gender: String { get }
    var address: String { get }
    var phone: String { get }
}
class UserDetailsViewModel: UserDetailsViewModelProtocol {
    private let user: UserViewModel

    var userImageUrl: URL? {
        user.pic
    }
    
    var username: String {
        user.name
    }
    
    var email: String {
        user.email
    }
    
    var gender: String {
        user.gender
    }
    
    var address: String {
        user.address
    }
    
    var phone: String {
        user.phone
    }

    init(user: UserViewModel) {
        self.user = user
    }
}
