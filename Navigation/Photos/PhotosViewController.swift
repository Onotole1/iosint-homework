//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 01.06.2025.
//

import UIKit

class PhotosViewController: UIViewController {
    private static let rowCount = 3.0
    private static let offset = 8.0

    private let images = GetPhotos.shared.getImages().map {
        PhotoViewModelItem(image: $0)
    }

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = Self.offset
        layout.minimumLineSpacing = Self.offset
        layout.sectionInset = UIEdgeInsets(top: Self.offset, left: Self.offset, bottom: Self.offset, right: Self.offset)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.register(PhotoCollectionViewCell.self)

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupCollectionView()
    }

    private func setupNavigationBar() {
        showNavigationBar()
        title = "Photo Gallery"
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self

        view.addSubview(collectionView)

        collectionView.setupConstraints {
            [
                $0.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                $0.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            ]
        }
    }
}

// MARK: - UICollectionViewDataSource
extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath,
    ) -> UICollectionViewCell {
        let cell: PhotoCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        let image = images[indexPath.item].image
        cell.configure(with: image)

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let padding: CGFloat = Self.offset * 2
        let spacing: CGFloat = Self.offset * 2
        let availableWidth = collectionView.frame.width - padding - spacing
        let itemWidth = availableWidth / Self.rowCount
        return CGSize(width: itemWidth, height: itemWidth)
    }
}
