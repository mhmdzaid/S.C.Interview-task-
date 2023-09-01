//
//  UsersViewModel.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 31/08/2023.
//

import Foundation
import Alamofire
protocol UsersViewModelProtocol: UserTableViewCellDelegate {
    var numberOfUsers: Int { get }
    var state: ContentState { get set }
    var numberOfUsersAtShimmeringState: Int { get set }
    var onStateUpdate: ((_ state: ContentState) -> ())? { get set }
    func getUsers()
    func getUser(with index: Int) -> UserViewModel
    func searchUsers(with keyword: String)
    func refreshList()
}
class UsersViewModel: UsersViewModelProtocol {
    private let service: Service
    private let localStorage: Storeable
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
    
    init(service: Service = UsersService(),
         storage: Storeable = Storage.shared) {
        self.service = service
        localStorage = storage
    }
    
    var onStateUpdate: ((_ state: ContentState) -> ())?

    func getUsers() {
        state = page == 1 ? .firstTimeLoading : .loading
        service.getUsers(from: page) {[weak self] result in
            guard let self else { return }
            switch result {
            case .success(let users):
                let mappedUsers = mapBookmarkedUsers(_users: users)
                self.users.append(contentsOf: mappedUsers)
                self.usersHolder.append(contentsOf: mappedUsers)
                state = .populated
                page += 1
                
            case .failure(_):
                state = .error
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
        users = usersHolder.filter({$0.name.contains(keyword)})
        state = users.isEmpty ? .empty : .searching
    }
    
    func refreshList() {
        users = []
        usersHolder = []
        page = 1
        getUsers()
    }
    
    func mapBookmarkedUsers(_users: [UserViewModel]) -> [UserViewModel] {
        let bookMarkedUsers = localStorage.fetchUsers()
        _users.forEach { user in
            user.isBookMarked = bookMarkedUsers.contains(where: { return $0.id == user.id })
        }
        return _users
    }
}

// MARK: - UserTableViewCellDelegate

extension UsersViewModel {
    func didBookmark(_ user: UserViewModel?, _ cell: UserTableViewCell) {
        guard let user else { return }
        if user.isBookMarked {
            localStorage.delete(user)
        } else {
            localStorage.save(user)
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
}
