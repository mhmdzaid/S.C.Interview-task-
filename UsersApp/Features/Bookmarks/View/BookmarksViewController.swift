//
//  BookmarksViewController.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 01/09/2023.
//

import UIKit

class BookmarksViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var tableViewHeight: CGFloat = 100
    var viewModel: BookmarksViewModelProtocol? = BookmarksViewModel()
    
    lazy var emptyView: UIView? = {
        let empty = Bundle.main.loadNibNamed("BookmarksEmptyView",owner: nil)?.first as? UIView
        empty?.embedIn(view: view)
        return empty
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.getBookmarkedUsers()
        viewModel?.onUserRemoval = { [weak self] contentState in
            
            guard let self else { return }
            switch contentState {
            case .empty:
                self.emptyView?.isHidden = false
                
            case .populated:
                self.emptyView?.isHidden = true 
                self.tableView.reloadData()
                
            default :
                break
            }
            view.layoutIfNeeded()
        }
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
        cell.delegate = viewModel
        cell.populateWith(user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = viewModel?.getUser(with: indexPath.row),
              let detailsVC = instance(of: UserDetailsViewController.self) else { return }
        
        detailsVC.viewModel = UserDetailsViewModel(user: user)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewHeight
    }
}
