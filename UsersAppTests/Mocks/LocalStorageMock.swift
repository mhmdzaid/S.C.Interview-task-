//
//  LocalStorageMock.swift
//  UsersAppTests
//
//  Created by Mohamed Elmalhey on 02/09/2023.
//

import Foundation
@testable import UsersApp

class LocalStorageMock: RepositoryDataSource {
    func fetchUsers() -> [UserViewModel] {
           
        let location = Location(street: Street(number: 6057, name: "Avondale"),
                                city: "AveNewYork",
                                state: "NewYork",
                                country: "United States")
        let name = Name(title: "Mr", first: "Karl", last: "Johnson")

        return [ UserViewModel(user: User(gender: "male",
                                          name: name,
                                          location: location,
                                          email: "karl.johnson@example.com",
                                          dob: Dob(date: "", age: 30),
                                          registered: Dob(date: "", age: 30),
                                          phone: "(268) 420-4900",
                                          cell: "",
                                          login: Login(uuid: ""),
                                          picture: Picture(large: "", medium: "", thumbnail: ""),
                                          nat: "")) ]
        
    }
    func save(_ user: UserViewModel) {}
    func delete(_ user: UserViewModel) {}
}
