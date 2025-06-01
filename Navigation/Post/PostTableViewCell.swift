//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 22.05.2025.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    // MARK: - Subviews

    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2

        return label
    }()

    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black

        return imageView
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0

        return label
    }()

    private lazy var likesLabel: UILabel = {
        createCounterLabel()
    }()

    private lazy var viewsLabel: UILabel = {
        createCounterLabel()
    }()

    private func createCounterLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black

        return label
    }

    // MARK: - Lifecycle

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

    // MARK: - Private

    private func tuneView() {
        selectionStyle = .none
    }

    private func addSubviews() {
        [authorLabel, photoImageView, descriptionLabel, likesLabel, viewsLabel].forEach { contentView.addSubview($0) }
    }

    private func setupConstraints() {
        let commonSpacing = 16.0

        authorLabel.setupConstraints {
            [
                $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: commonSpacing),
                $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: commonSpacing),
                $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: commonSpacing),
            ]
        }

        photoImageView.setupConstraints {
            [
                $0.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: commonSpacing),
                $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                $0.heightAnchor.constraint(equalTo: photoImageView.widthAnchor),
            ]
        }

        descriptionLabel.setupConstraints {
            [
                $0.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: commonSpacing),
                $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: commonSpacing),
                $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -commonSpacing),
            ]
        }

        likesLabel.setupConstraints {
            [
                $0.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: commonSpacing),
                $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: commonSpacing),
                $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -commonSpacing),
            ]
        }

        viewsLabel.setupConstraints {
            [
                $0.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: commonSpacing),
                $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -commonSpacing),
                $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -commonSpacing),
            ]
        }
    }

    // MARK: - Public

    func update(_ model: PostViewModelItem) {
        authorLabel.text = model.author
        photoImageView.image = UIImage(named: model.image)
        descriptionLabel.text = model.description
        likesLabel.text = "Likes: \(model.likes)"
        viewsLabel.text = "Views: \(model.views)"
    }
}
