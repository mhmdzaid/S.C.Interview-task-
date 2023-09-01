//
//  UserTableViewCell.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 01/09/2023.
//

import UIKit
import SkeletonView
import SDWebImage

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet var shimmerviews: [UIView]!
    private var userImageCornerRadius: CGFloat = 30
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.layer.cornerRadius = userImageCornerRadius
    }

    func populateWith(_ user: UserViewModel?) {
        userNameLabel.text = user?.name ?? ""
        emailLabel.text = user?.email ?? ""
        userImageView.sd_setImage(with: user?.pic)
    }
    
    func startShimmer() {
        shimmerviews.forEach({$0.showAnimatedSkeleton()})
    }

    func stopShimmer() {
        shimmerviews.forEach({$0.hideSkeleton()})
    }

    @IBAction func bookMarkUser(_ sender: UIButton) {
        
    }
    
}
