//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 22.05.2025.
//

import UIKit
import SnapKit
import iOSIntPackage

class PostTableViewCell: UITableViewCell {

    private let imageProcessor = ImageProcessor()

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

    private lazy var likesLabel: UILabel = createCounterLabel()

    private lazy var viewsLabel: UILabel = createCounterLabel()

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
        [authorLabel, photoImageView, descriptionLabel, likesLabel, viewsLabel].forEach(contentView.addSubview)
    }

    private func setupConstraints() {
        let commonSpacing = 16.0

        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(commonSpacing)
            make.leading.equalTo(contentView.snp.leading).offset(commonSpacing)
            make.trailing.equalTo(contentView.snp.trailing).offset(-commonSpacing)
        }

        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(commonSpacing)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.height.equalTo(photoImageView.snp.width)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(commonSpacing)
            make.leading.equalTo(contentView.snp.leading).offset(commonSpacing)
            make.trailing.equalTo(contentView.snp.trailing).offset(-commonSpacing)
        }

        likesLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(commonSpacing)
            make.leading.equalTo(contentView.snp.leading).offset(commonSpacing)
            make.bottom.equalTo(contentView.snp.bottom).offset(-commonSpacing)
        }

        viewsLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(commonSpacing)
            make.trailing.equalTo(contentView.snp.trailing).offset(-commonSpacing)
            make.bottom.equalTo(contentView.snp.bottom).offset(-commonSpacing)
        }
    }

    // MARK: - Public

    func update(_ model: PostViewModelItem) {
        authorLabel.text = model.author
        let originalImage = UIImage(named: model.image)!
        imageProcessor.processImageAsync(
            sourceImage: originalImage,
            filter: ColorFilter.monochrome(color: CIColor.red, intensity: 0.5),
        ) { processedImage in
            DispatchQueue.main.async {
                self.photoImageView.image = processedImage.map { UIImage(cgImage: $0) } ?? originalImage
            }
        }
        descriptionLabel.text = model.description
        likesLabel.text = "Likes: \(model.likes)"
        viewsLabel.text = "Views: \(model.views)"
    }
}
