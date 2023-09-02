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
    private var repo: RepositoryProtocol
    var unbookmarkedUsers: [String] = []

    var onUserRemoval: ((ContentState) -> Void)?

    var numberOfUsers: Int {
        return users.count
    }

    init(repo: RepositoryProtocol = Repository()) {
        self.repo = repo
    }

    func getBookmarkedUsers() {
        Task {
            users = await repo.getUsers(.local)
            
            DispatchQueue.main.async {
                self.onUserRemoval?(self.users.isEmpty ? .empty : .populated)
            }
        }
    }

    func getUser(with index: Int) -> UserViewModel {
        return users[index]
    }
    
    func didBookmark(_ user: UserViewModel?, _ cell: UserTableViewCell) {
        guard let user else { return }
        repo.delete(user: user)
        users.removeAll(where: {$0.id == user.id})
        onUserRemoval?(users.isEmpty ? .empty : .populated)
        user.isBookMarked = !user.isBookMarked
    }
}
