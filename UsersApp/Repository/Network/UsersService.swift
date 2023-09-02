//
//  Network.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 31/08/2023.
//

import Foundation
import Alamofire

protocol WebService {
    func getUsers(from page: Int) async throws -> [UserViewModel]
}
extension WebService {
    func getUsers(from page: Int) async throws -> [UserViewModel] { return [] }
}

public class UsersService: RepositoryDataSource {
    var mapper: Mapper = UsersMapper()
    var caller: Session? = AF
    func getUsers(from page: Int) async throws -> [UserViewModel] {
        try await withUnsafeThrowingContinuation { continuation in
            
            caller?.request("https://randomuser.me/api/?page=\(page)&results=25&seed=abc")
                .responseDecodable(of: UserModel.self) { response in
                    switch response.result {
                    case .success(let _response):
                        let users = self.mapper.mapUsers(_response)
                        continuation.resume(returning: users)
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
