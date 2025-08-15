//
//  CoordinatorImpl.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 14.07.2025.
//

import UIKit
import Swinject

final class AppCoordinatorImpl: AppCoordinator {
    private let container: Container

    init(container: Container) {
        self.container = container
    }

    func start() {
        let window = container.resolve(UIWindow.self)!
        let loginDelegate = container.resolve(LoginViewControllerDelegate.self)!
        let loginViewController = container.resolve(LogInViewController.self)!
        loginViewController.delegate = loginDelegate
        window.rootViewController = loginViewController
    }

    func showMainScreen() {
        let mainCoordinator = container.resolve(MainBaseCoordinator.self)!

        AppNavigation.resetToNewRootViewController(mainCoordinator.start())
    }
}
