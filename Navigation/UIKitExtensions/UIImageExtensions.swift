//
//  UIImageExtensions.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 21.05.2025.
//

import UIKit

extension UIImage {
    func withAlpha(_ alpha: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
