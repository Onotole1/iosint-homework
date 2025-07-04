//
//  UIViewControllerExtensions.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 18.05.2025.
//

import UIKit

extension UIViewController {
    var safeAreaLayoutGuide: UILayoutGuide {
        return view.safeAreaLayoutGuide
    }

    func hideNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }

    func showNavigationBar() {
        navigationController?.isNavigationBarHidden = false
    }
}
