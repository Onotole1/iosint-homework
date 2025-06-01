//
//  CustomCollectionViewCell.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 02.06.2025.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentView.addSubview(imageView)

        imageView.setupConstraints {
            [
                $0.topAnchor.constraint(equalTo: contentView.topAnchor),
                $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ]
        }
    }

    func configure(with image: UIImage) {
        imageView.image = image
    }
}
