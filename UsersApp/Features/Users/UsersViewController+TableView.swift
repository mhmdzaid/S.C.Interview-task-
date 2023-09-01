//
//  UsersViewController+TableView.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 01/09/2023.
//

import Foundation
import UIKit
extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.state == .firstTimeLoading ?
        viewModel?.numberOfUsersAtShimmeringState ?? 0 :
        viewModel?.numberOfUsers ?? 0
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeue(cellType: UserTableViewCell.self, indexPath: indexPath)
        else { return UITableViewCell() }
        if viewModel?.state == .firstTimeLoading {
            cell.startShimmer()
        } else {
            cell.stopShimmer()
            cell.populateWith(viewModel?.getUser(with: indexPath.row))
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewHeight
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let numberOfUsers = viewModel?.numberOfUsers ?? 0
        if indexPath.row == numberOfUsers - 1, viewModel?.state != .searching {
            viewModel?.getUsers()
        }
    }
}
