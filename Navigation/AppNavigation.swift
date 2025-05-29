//
//  AppNavigation.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 29.05.2025.
//
import UIKit

struct AppNavigation {
    static func resetToNewRootViewController(_ viewController: UIViewController, animated: Bool = true) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }

        if animated {
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window.rootViewController = UINavigationController(rootViewController: viewController)
            }, completion: nil)
        } else {
            window.rootViewController = UINavigationController(rootViewController: viewController)
        }
        window.makeKeyAndVisible()
    }
}
