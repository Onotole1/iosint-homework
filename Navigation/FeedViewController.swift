//
//  FeedViewController.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 11.05.2025.
//

import UIKit

class FeedViewController: UIViewController {

    private lazy var stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    private lazy var buttons = {
        let buttons = [UIButton(type: .system), UIButton(type: .system)]

        buttons
            .enumerated()
            .forEach { index, button in
                button.setTitle("To post \(index + 1)", for: .normal)
            }

        return buttons
    }()

    private let postViewControllerFactory: PostViewControllerFactory

    init(postViewControllerFactory: PostViewControllerFactory) {
        self.postViewControllerFactory = postViewControllerFactory
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        buttons.forEach { stackView.addArrangedSubview($0) }
        buttons.forEach { (button: UIButton) in
            button.on(.touchUpInside) { [weak self] _ in
                guard let self else { return }
                self.navigationController?.pushViewController(
                    self.postViewControllerFactory.create(nil),
                    animated: true
                )
            }
        }

        view.addSubview(stackView)

        stackView.setupConstraints {
            [
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                $0.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ]
        }
    }
}
