//
//  CoordinatorImpl.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 14.07.2025.
//

import UIKit
import Swinject

final class CoordinatorImpl: Coordinator {
    private let container: Container

    init(container: Container) {
        self.container = container
    }

    func start() {
        let window = container.resolve(UIWindow.self)!
        window.rootViewController = container.resolve(LogInViewController.self)!
    }

    func showMainScreen() {
        let uitabbarcontroller = UITabBarController()

        let feedViewController = UINavigationController(rootViewController: container.resolve(FeedViewController.self)!)
        feedViewController.tabBarItem.image = UIImage(systemName: "house")
        feedViewController.tabBarItem.title = "Feed"

        let userService = container.resolve(UserService.self)!
        let currentUser = userService.user
        let profileViewControllerFactory = container.resolve(ProfileViewControllerFactory.self)!
        let profileViewController = UINavigationController(
            rootViewController: profileViewControllerFactory.create(user: currentUser),
        )
        profileViewController.tabBarItem.image = UIImage(systemName: "person.circle")
        profileViewController.tabBarItem.title = "Profile"

        uitabbarcontroller.viewControllers = [feedViewController, profileViewController]
        uitabbarcontroller.selectedIndex = 1

        AppNavigation.resetToNewRootViewController(uitabbarcontroller)
    }
}
