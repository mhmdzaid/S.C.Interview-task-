//
//  Mapper.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 01/09/2023.
//

import Foundation

protocol Mapper {
    func mapUsers(_ model: UserModel) -> [UserViewModel]
    func mapUsers(_ users: [UserEntity]) -> [UserViewModel]
}
public class UsersMapper: Mapper {
    func mapUsers(_ model: UserModel) -> [UserViewModel] {
        return model.results.map({return UserViewModel(user: $0)})
    }
    
    func mapUsers(_ users: [UserEntity]) -> [UserViewModel] {
        return users.map({return UserViewModel(user: $0)})
    }
}
