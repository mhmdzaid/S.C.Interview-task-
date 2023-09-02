//
//  WebServiceMock.swift
//  UsersAppTests
//
//  Created by Mohamed Elmalhey on 02/09/2023.
//

import Foundation
@testable import UsersApp

class WebServiceMock: RepositoryDataSource {
    var currentPage = 0
    
    func getUsers(from page: Int) async throws -> [UserViewModel] {
        currentPage = page
        if let bundlePath = Bundle(for: type(of: self)).path(forResource: "users_stub", ofType: "json"),
           let jsonData = try? String(contentsOfFile: bundlePath).data(using: .utf8) {
            do {
                let model = try JSONDecoder().decode(UserModel.self, from: jsonData)
                print(UsersMapper().mapUsers(model).count)
                return  UsersMapper().mapUsers(model)
            } catch let error {
                print(error.localizedDescription)
            }
            
        } else {
            print("Given JSON is not a valid dictionary object.")
        }
        return []
    }
}
