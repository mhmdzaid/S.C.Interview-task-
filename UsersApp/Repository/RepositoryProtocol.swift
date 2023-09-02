//
//  RepositoryProtocol.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 02/09/2023.
//

import Foundation

enum ServiceType {
    case api(Int)
    case local
}
protocol RepositoryProtocol {
    func getUsers(_ type: ServiceType) async -> [UserViewModel]
    func save(user: UserViewModel)
    func delete(user: UserViewModel)
}
