//
//  UIImage+Extension.swift
//  UsersApp
//
//  Created by Mohamed Elmalhey on 03/09/2023.
//

import Foundation
import UIKit

extension UIImage {
    func rounded(radius: CGFloat) -> UIImage? {
    let rect = CGRect(origin: .zero, size: size)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    defer { UIGraphicsEndImageContext() }
    let bezierPath = UIBezierPath(roundedRect: rect, cornerRadius: radius)
    bezierPath.addClip()
    bezierPath.lineWidth = 10
    draw(in: rect)
    guard let context = UIGraphicsGetCurrentContext() else { return nil }
    context.setStrokeColor(UIColor.black.cgColor)
    bezierPath.lineWidth = 10
    bezierPath.stroke()
    return UIGraphicsGetImageFromCurrentImageContext() }
}
