//
//  UserViewModel.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 31/08/2023.
//

import Foundation

class UserViewModel {
    let id: String
    let name: String
    let email: String
    let pic: URL?
    let picUrlString: String?
    let gender: String
    let address: String
    let phone: String
    var isBookMarked: Bool = false

    init(user: User?) {
        let userName = user?.name
        let location = user?.location
        let street = location?.street
        let streetString = "\(street?.number ?? 0)" + " " + (street?.name ?? "")
        id = user?.login.uuid ?? ""
        name = (userName?.title ?? "") + ". " + (userName?.first ?? "") + " " + (userName?.last ?? "")
        email = user?.email ?? ""
        picUrlString =  user?.picture.large ?? ""
        pic = URL(string: picUrlString ?? "")
        gender = user?.gender ?? ""
        address = streetString + [location?.city ?? "", location?.state ?? "", location?.country ?? ""].joined(separator: "-")
        phone = user?.phone ?? ""
    }
    
    init(user: UserEntity) {
        id = user.id ?? ""
        name = user.name ?? ""
        email = user.email ?? ""
        picUrlString = user.photo ?? ""
        address = user.address ?? ""
        gender = user.gender ?? ""
        phone = user.phone ?? ""
        pic = URL(string: picUrlString ?? "")
    }
}
