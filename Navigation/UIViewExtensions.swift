//
//  UIViewExtensions.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 16.05.2025.
//

import UIKit

extension UIView {
    @discardableResult
    func setupConstraints(_ constraints: (UIView) -> [NSLayoutConstraint]) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraintsToActivate = constraints(self)
        NSLayoutConstraint.activate(constraintsToActivate)
        return self
    }
}
