//
//  BookmarksViewModel.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 01/09/2023.
//

import Foundation
protocol BookmarksViewModelProtocol: UserTableViewCellDelegate {
    var numberOfUsers: Int { get }
    var onUserRemoval: ((ContentState) -> Void)? { get set }
    func getUser(with index: Int) -> UserViewModel
    func getBookmarkedUsers()
}
class BookmarksViewModel: BookmarksViewModelProtocol {
    private var users: [UserViewModel] = []
    private var storage: Storeable
    var unbookmarkedUsers: [String] = []

    var onUserRemoval: ((ContentState) -> Void)?

    var numberOfUsers: Int {
        return users.count
    }

    init(storage: Storeable = Storage.shared) {
        self.storage = storage
    }

    func getBookmarkedUsers() {
        users = storage.fetchUsers()
        onUserRemoval?(users.isEmpty ? .empty : .populated)
    }

    func getUser(with index: Int) -> UserViewModel {
        return users[index]
    }
    
    func didBookmark(_ user: UserViewModel?, _ cell: UserTableViewCell) {
        guard let user else { return }
        storage.delete(user)
        users.removeAll(where: {$0.id == user.id})
        onUserRemoval?(users.isEmpty ? .empty : .populated)
        user.isBookMarked = !user.isBookMarked
    }
}
