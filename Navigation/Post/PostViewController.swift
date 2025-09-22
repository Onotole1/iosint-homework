//
//  PostViewController.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 11.05.2025.
//

import UIKit
import StorageService

protocol PostViewControllerFactory {
    func create(_ post: Post?) -> PostViewController
}

class PostViewControllerFactoryImpl: PostViewControllerFactory {
    private let feedCoordinator: FeedBaseCoordinator

    init(feedCoordinator: FeedBaseCoordinator) {
        self.feedCoordinator = feedCoordinator
    }

    func create(_ post: Post?) -> PostViewController {
        PostViewController(post, feedCoordinator: feedCoordinator)
    }
}

class PostViewController: UIViewController {
    private var post: Post?
    private let feedCoordinator: FeedBaseCoordinator

    init(_ post: Post?, feedCoordinator: FeedBaseCoordinator) {
        self.post = post
        self.feedCoordinator = feedCoordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Empty post"
        view.backgroundColor = .systemPink

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "info.circle"),
            style: .plain,
            target: self,
            action: #selector(showInfo)
        )
    }

    @objc private func showInfo() {
        feedCoordinator.showInfo()
    }
}
