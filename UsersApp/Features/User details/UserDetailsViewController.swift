//
//  UserDetailsViewController.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 01/09/2023.
//

import UIKit

class UserDetailsViewController: UIViewController {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    private var imageViewCornerRadius: CGFloat = 75
    var viewModel: UserDetailsViewModelProtocol?
    
    lazy var bookMarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        button.addTarget(self, action: #selector(bookMarkPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUsersInfo()
        addBookMarkButton()
    }

    @objc func bookMarkPressed() {
        print("hello world ")
    }

    fileprivate func setUsersInfo() {
        userImageView.sd_setImage(with: viewModel?.userImageUrl)
        userImageView.layer.cornerRadius = imageViewCornerRadius
        usernameLabel.text = viewModel?.username ?? ""
        emailLabel.text = viewModel?.email ?? ""
        genderLabel.text = viewModel?.gender ?? ""
        addressLabel.text = viewModel?.address ?? ""
        phoneLabel.text = viewModel?.phone ?? ""
    }

    fileprivate func addBookMarkButton() {
        let bookMarkItem = UIBarButtonItem(customView: bookMarkButton)
        navigationItem.setRightBarButton(bookMarkItem,animated: true)
    }
}
