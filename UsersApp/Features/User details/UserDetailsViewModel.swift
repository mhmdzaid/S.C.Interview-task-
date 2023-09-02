//
//  UserDetailsViewModel.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 01/09/2023.
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
class UserDetailsViewModel: UserDetailsViewModelProtocol {
    private let user: UserViewModel
    private let repo: RepositoryProtocol
    var onUserBookmarkStateChange: ((Bool) -> Void)?
    
    var userImageUrl: URL? {
        user.pic
    }
    
    var username: String {
        user.name
    }
    
    var email: String {
        user.email
    }
    
    var gender: String {
        user.gender
    }
    
    var address: String {
        user.address
    }
    
    var phone: String {
        user.phone
    }

    var isBookmarked: Bool {
        user.isBookMarked
    }

    init(user: UserViewModel, repo: RepositoryProtocol = Repository()) {
        self.user = user
        self.repo = repo
    }
    
    func bookmarkButtonPressed() {
        if isBookmarked {
            repo.delete(user: user)
        } else {
            repo.save(user: user)
        }
        user.isBookMarked = !isBookmarked
        onUserBookmarkStateChange?(isBookmarked)
    }
}
