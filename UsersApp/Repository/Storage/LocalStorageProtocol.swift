//
//  LocalStorageProtocol.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 02/09/2023.
//

import Foundation
protocol LocalStorageProtocol {
    func fetchUsers() -> [UserViewModel]
    func save(_ user: UserViewModel)
    func delete(_ user: UserViewModel)
}
extension LocalStorageProtocol {
    func fetchUsers() -> [UserViewModel] { return [] }
    func save(_ user: UserViewModel) {}
    func delete(_ user: UserViewModel) {}
}
