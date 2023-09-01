//
//  UserTableViewCell.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 01/09/2023.
//

import UIKit
import SkeletonView
import SDWebImage
protocol UserTableViewCellDelegate {
    func didBookmark(_ user: UserViewModel?,_ cell: UserTableViewCell)
}
class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet var shimmerviews: [UIView]!
    private var userImageCornerRadius: CGFloat = 30
    private var user: UserViewModel?
    var delegate: UserTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.layer.cornerRadius = userImageCornerRadius
    }

    func populateWith(_ user: UserViewModel?) {
        let isBookmarked = user?.isBookMarked ?? false
        self.user = user
        userNameLabel.text = user?.name ?? ""
        emailLabel.text = user?.email ?? ""
        userImageView.sd_setImage(with: user?.pic)
        let image = UIImage(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
        bookmarkButton.setImage(image, for: .normal)
    }
    
    func startShimmer() {
        shimmerviews.forEach({$0.showAnimatedSkeleton()})
    }

    func stopShimmer() {
        shimmerviews.forEach({$0.hideSkeleton()})
    }

    @IBAction func bookMarkUser(_ sender: UIButton) {
        let isBookmarked = user?.isBookMarked ?? false
        let image = UIImage(systemName: isBookmarked ? "bookmark" : "bookmark.fill")
        sender.setImage(image, for: .normal)
        delegate?.didBookmark(user, self)
    }
}
