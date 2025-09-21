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

    private lazy var resultLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        alertButton.setTitle("Alert", for: .normal)

        view.backgroundColor = .systemBackground
        [alertButton, resultLabel].forEach(view.addSubview)

        setupConstraints()
    }

    private func setupConstraints() {
        alertButton.setupConstraints {
            [
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                $0.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ]
        }

        resultLabel.setupConstraints {
            [
                $0.topAnchor.constraint(equalTo: alertButton.bottomAnchor, constant: 16),
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ]
        }
    }

    private func didTapLoadButton() {
        Task {
            let result = await NetworkService.request(for: AppConfiguration.planet(url: URL(string: "https://swapi.dev/api/planets/5")!))
                .flatMap { data -> Result<String, NetworkError> in
                    do {
                        // swiftlint:disable force_cast
                        let response = try JSONSerialization.jsonObject(with: data.data, options: []) as! [String: Any]
                        let name: String = response["name"] as! String
                        // swiftlint:enable force_cast
                        return .success(name)
                    } catch {
                        return .failure(NetworkError.decodingError(error))
                    }
                }

            await MainActor.run {
                switch result {
                case .success(let name):
                    self.resultLabel.text = name
                case .failure(let error):
                    self.resultLabel.text = error.localizedDescription
                }
            }
        }
    }
}
