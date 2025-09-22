//
//  InfoViewController.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 11.05.2025.
//

import UIKit
import Combine

class InfoViewController: UIViewController {
    private lazy var loadButton = {
        CustomButton.make(
            buttonType: .system,
            title: "Load",
        ) { [weak self] in
            self?.viewOutput.onLoadAction()
        }
    }()

    private lazy var nameLabel = UILabel()
    private lazy var rotationPeriodLabel = UILabel()
    private lazy var tableView = {
        let tableView = UITableView()

        tableView.register(PersonViewCell.self)

        tableView.dataSource = self

        return tableView
    }()
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    private var cancellables = Set<AnyCancellable>()
    private let viewOutput: PlanetViewOutput
    private var currentState: PlanetLoadableData = PlanetLoadableData()

    init(viewOutput: PlanetViewOutput) {
        self.viewOutput = viewOutput
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        [loadButton, nameLabel, rotationPeriodLabel, activityIndicatorView, tableView].forEach(view.addSubview)

        setupConstraints()
        subscribeToViewModel()
    }

    private func setupConstraints() {
        loadButton.setupConstraints {
            [
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                $0.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ]
        }

        nameLabel.setupConstraints {
            [
                $0.topAnchor.constraint(equalTo: loadButton.bottomAnchor, constant: 16),
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ]
        }

        rotationPeriodLabel.setupConstraints {
            [
                $0.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ]
        }

        tableView.setupConstraints {
            [
                $0.topAnchor.constraint(equalTo: rotationPeriodLabel.bottomAnchor, constant: 16),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ]
        }

        activityIndicatorView.setupConstraints {
            [
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                $0.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ]
        }
    }

    private func subscribeToViewModel() {
        viewOutput.state.sink { [weak self] state in
            guard let self else { return }
            currentState = state
            switch state.status {
            case .idle:
                nameLabel.isHidden = false
                nameLabel.text = state.value?.planetName
                rotationPeriodLabel.text = state.value?.rotationPeriod
                activityIndicatorView.stopAnimating()
                loadButton.isHidden = state.value != nil
                tableView.reloadData()
            case .loading:
                nameLabel.isHidden = true
                rotationPeriodLabel.isHidden = true
                activityIndicatorView.startAnimating()
                loadButton.isHidden = true
            case .error(let error):
                nameLabel.isHidden = false
                nameLabel.text = error.localizedDescription
                rotationPeriodLabel.isHidden = true
                activityIndicatorView.stopAnimating()
                loadButton.isHidden = false
            }
        }
        .store(in: &cancellables)
    }
}

extension InfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentState.value?.residents.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = currentState.value?.residents[indexPath.row] else {
            fatalError("State not loaded yet")
        }

        let cell: PersonViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.update(item.person)
        cell.retryAction = { [weak self] in
            self?.viewOutput.onLoadPersonAction(item.url)
        }
        return cell
    }
}
