//
//  UsersViewController.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 31/08/2023.
//

import UIKit
import SkeletonView
public class UsersViewController: UIViewController {
    @IBOutlet weak var notFoundView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: UsersViewModelProtocol? = UsersViewModel()
    private var tableViewHeight: CGFloat = 100
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setupTableView()
        handleStateUpdate()
        viewModel?.getUsers()
    }
    
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    fileprivate func createFooterSpinnerView() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = footerView.center
        footerView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        return footerView
    }
    
    fileprivate func handleStateUpdate() {
        viewModel?.onStateUpdate = {[weak self] state in
            guard let self else { return }
            self.notFoundView.isHidden = true
            switch state {
            case .loading:
                self.tableView.reloadData()
                self.tableView.tableFooterView = createFooterSpinnerView()
                
            case .populated, .searching:
                self.tableView.reloadData()
                self.tableView.tableFooterView = nil
            case .error:
                print("something went wrong ..!")
               
            case .empty:
                self.notFoundView.isHidden = false
                self.tableView.reloadData()
            default:
                break
            }
        }
    }
}

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


extension UITableView {
    
    func dequeue<T:UITableViewCell>(cellType: T.Type, indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withIdentifier: String(describing: cellType), for: indexPath) as? T
    }
}

extension UsersViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.searchUsers(with: searchBar.text ?? "")
    }
}
