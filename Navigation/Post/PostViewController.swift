//
//  PostViewController.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 11.05.2025.
//

import UIKit
import StorageService

class PostViewController: UIViewController {
    private var post: Post?

    init(_ post: Post?) {
        self.post = post
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
        present(InfoViewController(), animated: true)
    }
}
