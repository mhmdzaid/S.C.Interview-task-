//
//  BookmarksViewModelProtocol.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 02/09/2023.
//

import Foundation
protocol BookmarksViewModelProtocol: UserTableViewCellDelegate {
    var numberOfUsers: Int { get }
    var onUserRemoval: ((ContentState) -> Void)? { get set }
    func getUser(with index: Int) -> UserViewModel
    func getBookmarkedUsers()
}
