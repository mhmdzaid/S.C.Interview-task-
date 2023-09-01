//
//  UsersViewModel.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 31/08/2023.
//

import Foundation
import Alamofire
protocol UsersViewModelProtocol {
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
    
    init(service: Service = UsersService()) {
        self.service = service
    }
    
    var onStateUpdate: ((_ state: ContentState) -> ())?

    func getUsers() {
        state = page == 1 ? .firstTimeLoading : .loading
        service.getUsers(from: page) {[weak self] result in
            guard let self else { return }
            switch result {
            case .success(let users):
                self.users.append(contentsOf: users)
                self.usersHolder.append(contentsOf: users)
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
}

enum ContentState {
    case empty
    case firstTimeLoading
    case loading
    case populated
    case error
    case searching
}
