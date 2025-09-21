//
//  InfoViewController.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 11.05.2025.
//

import UIKit

class InfoViewController: UIViewController {
    private lazy var alertButton = {
        CustomButton.make(
            buttonType: .system,
            title: "Load",
        ) { [weak self] in
            self?.didTapLoadButton()
        }
    }()

    private lazy var nameLabel = UILabel()
    private lazy var rotationPeriodLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        [alertButton, nameLabel, rotationPeriodLabel].forEach(view.addSubview)

        setupConstraints()
    }

    private func setupConstraints() {
        alertButton.setupConstraints {
            [
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                $0.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ]
        }

        nameLabel.setupConstraints {
            [
                $0.topAnchor.constraint(equalTo: alertButton.bottomAnchor, constant: 16),
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ]
        }

        rotationPeriodLabel.setupConstraints {
            [
                $0.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ]
        }
    }

    private func didTapLoadButton() {
        Task {
            let result = await URLSession.shared.downloadData(from: URL(string: "https://swapi.dev/api/planets/1"))
                .flatMap { data -> Result<Planet, NetworkError> in
                    do {
                        let decoder = JSONDecoder()
                        return .success(try decoder.decode(Planet.self, from: data.data))
                    } catch {
                        return .failure(NetworkError.decodingError(error))
                    }
                }

            await MainActor.run {
                switch result {
                case .success(let planet):
                    self.nameLabel.text = planet.name
                    self.rotationPeriodLabel.text = planet.rotationPeriod
                case .failure(let error):
                    self.nameLabel.text = error.localizedDescription
                    self.rotationPeriodLabel.text = ""
                }
            }
        }
    }
}
