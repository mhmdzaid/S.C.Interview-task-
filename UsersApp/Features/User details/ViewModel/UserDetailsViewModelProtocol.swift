//
//  UserDetailsViewModelProtocol.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 02/09/2023.
//

import Foundation
protocol UserDetailsViewModelProtocol {
    var userImageUrl: URL? { get }
    var username: String { get }
    var email: String { get }
    var gender: String { get }
    var address: String { get }
    var phone: String { get }
    var isBookmarked: Bool { get }
    var onUserBookmarkStateChange: ((Bool) -> Void)? { get set }
    func bookmarkButtonPressed()
}
