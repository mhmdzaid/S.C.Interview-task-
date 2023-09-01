//
//  BookmarksViewController.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 01/09/2023.
//

import UIKit

class BookmarksViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: BookmarksViewModelProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.initialize()
    }
    
    
}
//MARK: BookmarksViewController + UITableView
extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfUsers ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeue(
            cellType: UserTableViewCell.self,
            indexPath: indexPath) else {
            return UITableViewCell()
        }
        let user = viewModel?.getUser(with: indexPath.row)
        cell.stopShimmer()
        cell.populateWith(user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = viewModel?.getUser(with: indexPath.row),
              let detailsVC = instance(of: UserDetailsViewController.self) else { return }
        
        detailsVC.viewModel = UserDetailsViewModel(user: user)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
