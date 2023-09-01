//
//  UserViewModel.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 31/08/2023.
//

import Foundation

class UserViewModel {
    let name: String
    let email: String
    let pic: URL?
    let gender: String
    let address: String
    let phone: String
    init(user: User?) {
        let userName = user?.name
        let location = user?.location
        let street = location?.street
        let streetString = "\(street?.number ?? 0)" + " " + (street?.name ?? "")
        name = (userName?.title ?? "") + ". " + (userName?.first ?? "") + " " + (userName?.last ?? "")
        email = user?.email ?? ""
        pic = URL(string: user?.picture.large ?? "")
        gender = user?.gender ?? ""
        address = streetString + [location?.city ?? "", location?.state ?? "", location?.country ?? ""].joined(separator: "-")
        phone = user?.phone ?? ""
    }
}
