//
//  Coordinatable.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 10.08.2025.
//
import UIKit

enum AppFlow {
    case feed
    case profile
}

protocol Coordinator {
    var rootViewController: UIViewController { get }
    func start() -> UIViewController
    @discardableResult func resetToRoot() -> Self
}

extension Coordinator {
    var navigationRootViewController: UINavigationController? {
        rootViewController as? UINavigationController
    }

    func resetToRoot() -> Self {
        navigationRootViewController?.popToRootViewController(animated: true)
        return self
    }
}

protocol FeedBaseCoordinator: Coordinator {
    var parentCoordinator: MainBaseCoordinator? { get set }
    func showPost()
    func showInfo()
}

protocol ProfileBaseCoordinator: Coordinator {
    var parentCoordinator: MainBaseCoordinator? { get set }
    func showPhotos()
}

protocol MainBaseCoordinator: Coordinator {
    var feedCoordinator: FeedBaseCoordinator { get }
    var profileCoordinator: ProfileBaseCoordinator { get }
    func moveTo(flow: AppFlow)
}
