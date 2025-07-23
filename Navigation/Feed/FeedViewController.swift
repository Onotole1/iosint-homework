//
//  FeedViewController.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 11.05.2025.
//

import UIKit
import Combine

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

    private lazy var guessTextField: UITextField = {
        let textField = UITextField()

        textField.placeholder = "Guess word"

        return textField
    }()

    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Result"
        return label
    }()

    private lazy var checkGuessButton: UIButton = {
        CustomButton.make(buttonType: .system, title: "Check") { [weak self] in
            guard let self else { return }
            feedModel.check(word: guessTextField.text ?? "")
        }
    }()

    private var cancellables = Set<AnyCancellable>()

    private let postViewControllerFactory: PostViewControllerFactory

    private let feedModel: FeedModel

    init(
        postViewControllerFactory: PostViewControllerFactory,
        feedModel: FeedModel,
    ) {
        self.postViewControllerFactory = postViewControllerFactory
        self.feedModel = feedModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        subscribeToModel()
    }

    private func setupView() {
        buttons.forEach(stackView.addArrangedSubview)
        buttons.forEach { (button: UIButton) in
            button.on(.touchUpInside) { [weak self] _ in
                guard let self else { return }
                self.navigationController?.pushViewController(
                    self.postViewControllerFactory.create(nil),
                    animated: true
                )
            }
        }

        [guessTextField, checkGuessButton, resultLabel].forEach(stackView.addArrangedSubview)

        view.addSubview(stackView)

        stackView.setupConstraints {
            [
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                $0.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ]
        }
    }

    private func subscribeToModel() {
        feedModel.checkWordResult.sink { [weak self] result in
            switch result {
            case .correct:
                self?.resultLabel.textColor = .green
            case .incorrect:
                self?.resultLabel.textColor = .red
            }
        }
        .store(in: &cancellables)
    }
}
