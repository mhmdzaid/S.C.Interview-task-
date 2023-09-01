//
//  Network.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 31/08/2023.
//

import Foundation
import Alamofire

protocol Service {
    func getUsers(from page: Int, completionHandler: @escaping(Result<[UserViewModel], AFError>) -> ())
}

public class UsersService: Service {
    var mapper: Mapper = UsersMapper()
    
    func getUsers(from page: Int, completionHandler: @escaping(Result<[UserViewModel], AFError>) -> ()) {
        AF.request("https://randomuser.me/api/?page=\(page)&results=25&seed=abc")
            .responseDecodable(of: UserModel.self) { response in
                switch response.result {
                case .success(let _response):
                    let users = self.mapper.mapUsers(_response)
                    completionHandler(.success(users))
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                }
            }
    }
}
