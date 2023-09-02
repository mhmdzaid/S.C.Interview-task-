//
//  Repository.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 02/09/2023.
//

import Foundation

protocol RepositoryDataSource: LocalStorageProtocol, WebService {}

class Repository: RepositoryProtocol {
    var dataSource: RepositoryDataSource?

    init(dataSource: RepositoryDataSource? = Storage()) {
        self.dataSource = dataSource
    }
    
    func getUsers(_ type: ServiceType) async -> [UserViewModel] {
        switch type {
        case .api(page: let pageNumber):
            return await getUsersFromApi(with: pageNumber)
            
        case .local:
            dataSource = Storage.shared
            return dataSource?.fetchUsers() ?? []
        }
    }
    
    private func getUsersFromApi(with page: Int) async -> [UserViewModel] {
        do {
            dataSource = UsersService()
            return try await dataSource?.getUsers(from: page) ?? []
        } catch let error {
            print(error.localizedDescription)
        }
        return []
    }
    
    func save(user: UserViewModel) {
        dataSource?.save(user)
    }
    
    func delete(user: UserViewModel) {
        dataSource?.delete(user)
    }
    
}

