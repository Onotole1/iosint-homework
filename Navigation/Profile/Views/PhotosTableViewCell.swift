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
        title.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(commonSpacing)
            make.top.equalTo(self.snp.top).offset(commonSpacing)
        }

        navigateIcon.snp.makeConstraints { make in
            make.centerY.equalTo(title.snp.centerY)
            make.trailing.equalTo(self.snp.trailing).offset(-commonSpacing)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(commonSpacing)
            make.leading.equalTo(self.snp.leading).offset(commonSpacing)
            make.trailing.equalTo(self.snp.trailing).offset(-commonSpacing)
            make.bottom.equalTo(self.snp.bottom).offset(-commonSpacing)
            make.height.equalTo(72)
        }

    }
}
