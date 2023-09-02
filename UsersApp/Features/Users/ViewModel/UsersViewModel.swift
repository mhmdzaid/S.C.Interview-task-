//
//  UsersViewModel.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 31/08/2023.
//

import Foundation
import Alamofire

class UsersViewModel: UsersViewModelProtocol {
    private var repo: RepositoryProtocol
    private var page = 1
    private var users: [UserViewModel] = []
    private var usersHolder: [UserViewModel] = []
    var numberOfUsersAtShimmeringState = 25
    var state: ContentState = .empty {
        didSet{
            onStateUpdate?(state)
        }
    }
    var numberOfUsers: Int {
        return users.count
    }
    
    init(repo: RepositoryProtocol = Repository()) {
        self.repo = repo
    }
    
    var onStateUpdate: ((_ state: ContentState) -> ())?
    
    func getUsers() {
        state = page == 1 ? .firstTimeLoading : .loading
        Task {
            let users = await repo.getUsers(.api(page))
            let mappedUsers = await mapBookmarkedUsers(_users: users)
            self.users.append(contentsOf: mappedUsers)
            self.usersHolder.append(contentsOf: mappedUsers)
            DispatchQueue.main.async {
                self.state = .populated
                self.page += 1
            }
        }
    }
    
    func getUser(with index: Int) -> UserViewModel {
        return users[index]
    }
    
    func searchUsers(with keyword: String) {
        guard !keyword.isEmpty else {
            users = usersHolder
            state = .populated
            return
        }
        users = usersHolder.filter({$0.name.lowercased().contains(keyword.lowercased())})
        state = users.isEmpty ? .notFound : .searching
    }
    
    func refreshList() {
        users.removeAll()
        usersHolder.removeAll()
        state = .empty
        page = 1
        getUsers()
    }
    
    func mapBookmarkedUsers(_users: [UserViewModel]) async -> [UserViewModel] {
        let bookMarkedUsers = await repo.getUsers(.local)
        _users.forEach { user in
            user.isBookMarked = bookMarkedUsers.contains(where: { return $0.id == user.id })
        }
        return _users
    }
    
    func resetRemovedUsers() {
        Task {
            users = await mapBookmarkedUsers(_users: users)
        }
    }
}

// MARK: - UserTableViewCellDelegate

extension UsersViewModel {
    func didBookmark(_ user: UserViewModel?, _ cell: UserTableViewCell) {
        guard let user else { return }
        if user.isBookMarked {
            repo.delete(user: user)
        } else {
            repo.save(user: user)
        }
        user.isBookMarked = !user.isBookMarked
    }
}

enum ContentState {
    case empty
    case firstTimeLoading
    case loading
    case populated
    case error
    case searching
    case notFound
}
