//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 16.08.2025.
//
import UIKit
import Swinject

class MainCoordinator: MainBaseCoordinator {
    var parentCoordinator: MainBaseCoordinator?
    var feedCoordinator: FeedBaseCoordinator
    var profileCoordinator: ProfileBaseCoordinator

    private lazy var tabBarController: UITabBarController = UITabBarController()
    lazy var rootViewController: UIViewController = tabBarController

    init(
        feedCoordinator: FeedBaseCoordinator,
        profileCoordinator: ProfileBaseCoordinator
    ) {
        self.feedCoordinator = feedCoordinator
        self.profileCoordinator = profileCoordinator
    }

    func start() -> UIViewController {
        let feedViewController = feedCoordinator.start()
        feedCoordinator.parentCoordinator = self
        feedViewController.tabBarItem = UITabBarItem(
            title: "Feed",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill"),
        )

        let profileViewController = profileCoordinator.start()
        profileCoordinator.parentCoordinator = self
        profileViewController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill"),
        )

        tabBarController.viewControllers = [feedViewController, profileViewController]

        return rootViewController
    }

    func moveTo(flow: AppFlow) {
        switch flow {
        case .feed:
            tabBarController.selectedIndex = 0
        case .profile:
            tabBarController.selectedIndex = 1
        }
    }

    func resetToRoot() -> Self {
        feedCoordinator.resetToRoot()
        moveTo(flow: .feed)
        return self
    }
}
