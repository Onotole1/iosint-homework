//
//  PersonViewCell.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 22.09.2025.
//
import UIKit

class PersonViewCell: UITableViewCell {
    private lazy var nameLabel = UILabel()
    private lazy var retryButton = {
        let button = UIButton(type: .system)
        button.setTitle("Retry", for: .normal)
        return button
    }()
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    private var person: Person?

    var retryAction: (() -> Void)?

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: .subtitle,
            reuseIdentifier: reuseIdentifier
        )

        tuneView()
        addSubviews()
        setupConstraints()
        setupListeners()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        isHidden = false
        isSelected = false
        isHighlighted = false
    }

    private func tuneView() {
        selectionStyle = .none
    }

    private func addSubviews() {
        [nameLabel, retryButton, activityIndicatorView].forEach(contentView.addSubview)
    }

    private func setupConstraints() {
        nameLabel.setupConstraints {
            [
                $0.topAnchor.constraint(equalTo: contentView.topAnchor),
                $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            ]
        }

        retryButton.setupConstraints {
            [
                $0.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor),
                $0.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            ]
        }

        activityIndicatorView.setupConstraints {
            [
                $0.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor),
                $0.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            ]
        }
    }

    private func setupListeners() {
        retryButton.on(.touchUpInside) { [weak self] _ in
            self?.retryAction?()
        }
    }

    func update(_ model: ReloadableData<Person, NetworkError>) {
        switch model.status {
        case .idle:
            activityIndicatorView.stopAnimating()
            retryButton.isHidden = true
            person = model.value

            if let person = model.value {
                nameLabel.text = person.name
            }
        case .loading:
            activityIndicatorView.startAnimating()
            retryButton.isHidden = true
        case .error(let error):
            nameLabel.text = error.localizedDescription
            activityIndicatorView.stopAnimating()
            retryButton.isHidden = false
        }
    }
}
