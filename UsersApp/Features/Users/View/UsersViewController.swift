//
//  UsersViewController.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 31/08/2023.
//

import UIKit
import SkeletonView
class UsersViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()
    var viewModel: UsersViewModelProtocol? = UsersViewModel()
    var tableViewHeight: CGFloat = 100
    
    lazy var notFoundView: UIView? = {
        let notFoundV = Bundle.main.loadNibNamed("UserNotFoundView",owner: nil)?.first as? UIView
        notFoundV?.embedIn(view: contentView)
        return notFoundV
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setupTableView()
        setUpRefreshControl()
        handleStateUpdate()
        viewModel?.getUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if tabBarController?.selectedViewController is BookmarksViewController {
            viewModel?.resetRemovedUsers()
        }
        let indecies = tableView.indexPathsForVisibleRows ?? []
        tableView.reloadRows(at: indecies, with: .fade)
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
                self.notFoundView?.isHidden = true

                switch state {
                case .loading:
                    self.tableView.reloadData()
                    self.tableView.tableFooterView = self.createFooterSpinnerView()
                    
                case .populated, .searching:
                    self.refreshControl.endRefreshing()
                    self.tableView.reloadData()
                    self.tableView.tableFooterView = nil
                    
                case .error:
                    print("something went wrong ..!")
                    
                case .notFound:
                    self.notFoundView?.isHidden = false
                    self.tableView.reloadData()
                    
                default:
                    self.tableView.reloadData()
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
