//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 16.08.2025.
//
import Swinject
import UIKit

class ProfileCoordinator: ProfileBaseCoordinator {
    var parentCoordinator: MainBaseCoordinator?
    var rootViewController = UIViewController()

    private let container: Container

    init(container: Container) {
        self.container = container
    }

    func start() -> UIViewController {
        let userService = container.resolve(UserService.self)!
        let currentUser = userService.user
        let profileViewControllerFactory = container.resolve(ProfileViewControllerFactory.self)!
        let profileViewController = profileViewControllerFactory.create(user: currentUser)
        rootViewController = UINavigationController(rootViewController: profileViewController)
        return rootViewController
    }

    func showPhotos() {
        navigationRootViewController?.pushViewController(container.resolve(PhotosViewController.self)!, animated: true)
    }
}
