//
//  UITableView+Extension.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 01/09/2023.
//

import Foundation
import UIKit

extension UITableView {
    func dequeue<T:UITableViewCell>(cellType: T.Type, indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withIdentifier: String(describing: cellType), for: indexPath) as? T
    }
}
