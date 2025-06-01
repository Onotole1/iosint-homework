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

    private let images = GetPhotos.fetch().map {
        PhotoViewModelItem(image: UIImage(named: $0)!)
    }

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = offset
        layout.minimumLineSpacing = offset
        layout.sectionInset = UIEdgeInsets(top: offset, left: offset, bottom: offset, right: offset)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.register(PhotoCollectionViewCell.self)

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

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
