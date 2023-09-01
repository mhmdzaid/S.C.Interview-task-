//
//  BookmarksViewModel.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 01/09/2023.
//

import Foundation
protocol BookmarksViewModelProtocol {
    var numberOfUsers: Int { get }
    func getUser(with index: Int) -> UserViewModel
    func initialize()
}
class BookmarksViewModel: BookmarksViewModelProtocol {
    private var users: [UserViewModel] = []
    var numberOfUsers: Int {
        return users.count
    }

    func initialize() {
        
    }

    func getUser(with index: Int) -> UserViewModel {
        return users[index]
    }
}
