//
//  RepositoryMock.swift
//  UsersAppTests
//
//  Created by Mohamed Elmalhey on 02/09/2023.
//

import Foundation
@testable import UsersApp

class RepositoryMock: RepositoryProtocol {
    var page: Int = 2
    var userTobeSaved: UserViewModel?
    var userTobeDeleted: UserViewModel?
    var dataSource: RepositoryDataSource?
    
    func getUsers(_ type: ServiceType) async -> [UserViewModel] {
        
        switch type {
        case .api(let page):
            self.page = page
            dataSource = WebServiceMock()
            let users = try! await dataSource?.getUsers(from: page) ?? []
            return users
            
        case .local:
            dataSource = LocalStorageMock()
            return dataSource?.fetchUsers() ?? []
        }
    }
    
    func save(user: UserViewModel) {
        userTobeSaved = user
    }
    
    func delete(user: UserViewModel) {
        userTobeDeleted = user
    }
}
