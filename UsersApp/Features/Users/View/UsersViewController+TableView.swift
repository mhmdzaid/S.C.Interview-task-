//
//  UsersViewController+TableView.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 01/09/2023.
//

import Foundation
import UIKit
extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.state == .firstTimeLoading ?
        viewModel?.numberOfUsersAtShimmeringState ?? 0 :
        viewModel?.numberOfUsers ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeue(cellType: UserTableViewCell.self, indexPath: indexPath)
        else { return UITableViewCell() }
        if viewModel?.state == .firstTimeLoading {
            cell.startShimmer()
        } else {
            let user = viewModel?.getUser(with: indexPath.row)
            cell.stopShimmer()
            cell.delegate = viewModel
            cell.populateWith(user)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let numberOfUsers = viewModel?.numberOfUsers ?? 0
        if indexPath.row == numberOfUsers - 1, viewModel?.state != .searching {
            viewModel?.getUsers()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = viewModel?.getUser(with: indexPath.row),
              let detailsVC = instance(of: UserDetailsViewController.self) else { return }
        
        detailsVC.viewModel = UserDetailsViewModel(user: user)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
