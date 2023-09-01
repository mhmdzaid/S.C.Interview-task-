//
//  UIView+Extension.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 02/09/2023.
//

import Foundation
import UIKit
extension UIView {
    
    func embedIn(view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
