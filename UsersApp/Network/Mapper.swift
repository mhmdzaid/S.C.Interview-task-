//
//  Mapper.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 01/09/2023.
//

import Foundation

protocol Mapper {
    func mapUsers(_ model: UserModel) -> [UserViewModel]
}
public class UsersMapper: Mapper {
    func mapUsers(_ response: UserModel) -> [UserViewModel] {
        return response.results.map({return UserViewModel(user: $0)})
    }
}
