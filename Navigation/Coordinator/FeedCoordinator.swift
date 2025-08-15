//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 16.08.2025.
//

import Swinject
import UIKit

class FeedCoordinator: FeedBaseCoordinator {
    var parentCoordinator: MainBaseCoordinator?
    var rootViewController = UIViewController()

    private let container: Container

    init(container: Container) {
        self.container = container
    }

    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: container.resolve(FeedViewController.self)!)
        return rootViewController
    }

    func showPost() {
        let factory = container.resolve(PostViewControllerFactory.self)!
        navigationRootViewController?.pushViewController(factory.create(nil), animated: true)
    }
}
