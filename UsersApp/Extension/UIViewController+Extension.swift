//
//  UIViewController+Extension.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 01/09/2023.
//

import Foundation
import UIKit
extension UIViewController {
    func instance<T: UIViewController>(of type: T.Type) -> T? {
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        return storyBoard.instantiateViewController(withIdentifier: String(describing: type)) as? T
    }
}
