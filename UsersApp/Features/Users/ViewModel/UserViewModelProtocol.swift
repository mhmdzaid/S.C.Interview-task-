//
//  UserViewModelProtocol.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 02/09/2023.
//

import Foundation
protocol UsersViewModelProtocol: UserTableViewCellDelegate {
    var numberOfUsers: Int { get }
    var state: ContentState { get set }
    var numberOfUsersAtShimmeringState: Int { get set }
    var onStateUpdate: ((_ state: ContentState) -> ())? { get set }
    func getUsers()
    func getUser(with index: Int) -> UserViewModel
    func searchUsers(with keyword: String)
    func refreshList() -> Void
    func resetRemovedUsers()
}
