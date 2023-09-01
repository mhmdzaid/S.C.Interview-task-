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
    var tableViewHeight: CGFloat = 100
    let refreshControl = UIRefreshControl()
    public override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setupTableView()
        setUpRefreshControl()
        handleStateUpdate()
        viewModel?.getUsers()
    }
    
    fileprivate func setUpRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Loading ...")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    @objc func refresh(_ sender: AnyObject) {
        viewModel?.refreshList()
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
                self.refreshControl.endRefreshing()
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
// MARK: UsersViewController + UISearchBarDelegate
extension UsersViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.searchUsers(with: searchBar.text ?? "")
    }
}
