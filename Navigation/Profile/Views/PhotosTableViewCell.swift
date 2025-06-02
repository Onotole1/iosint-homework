//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 30.05.2025.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    private lazy var title = {
        let title = UILabel()

        title.text = "Photos"
        title.textColor = .black
        title.font = .systemFont(ofSize: 24, weight: .bold)

        return title
    }()

    private lazy var navigateIcon: UIImageView = {
        let button = UIImageView(image: UIImage(systemName: "arrow.right"))
        button.tintColor = .black
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [title, navigateIcon])

        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8

        return stackView
    }()

    // MARK: - Update
    func update(images: [UIImage]) {
        let existingImageViews = stackView.arrangedSubviews.filter {
            $0 is UIImageView && $0 !== title && $0 !== navigateIcon
        }

        if existingImageViews.count > images.count {
            for index in images.count..<existingImageViews.count {
                existingImageViews[index].removeFromSuperview()
            }
        }

        for (index, image) in images.enumerated() {
            if index < existingImageViews.count {
                (existingImageViews[index] as? UIImageView)?.image = image
            } else {
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                imageView.layer.cornerRadius = 8
                stackView.addArrangedSubview(imageView)
            }
        }
    }

    // MARK: - Lifecycle

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        tuneView()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func tuneView() {
        selectionStyle = .none
    }

    private func addSubviews() {
        [title, navigateIcon, stackView].forEach(addSubview)
    }

    private func setupConstraints() {
        let commonSpacing: CGFloat = 12
        title.setupConstraints {
            [
                $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: commonSpacing),
                $0.topAnchor.constraint(equalTo: topAnchor, constant: commonSpacing),
            ]
        }

        navigateIcon.setupConstraints {
            [
                $0.centerYAnchor.constraint(equalTo: title.centerYAnchor),
                $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -commonSpacing),
            ]
        }

        stackView.setupConstraints {
            [
                $0.topAnchor.constraint(equalTo: title.bottomAnchor, constant: commonSpacing),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: commonSpacing),
                $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -commonSpacing),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -commonSpacing),
                $0.heightAnchor.constraint(equalToConstant: 72),
            ]
        }
    }
}
