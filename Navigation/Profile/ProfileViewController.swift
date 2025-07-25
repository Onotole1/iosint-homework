//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 11.05.2025.
//

import UIKit
import StorageService

protocol ProfileViewControllerFactory {
    func create(user: User) -> ProfileViewController
}

class ProfileViewControllerFactoryImpl: ProfileViewControllerFactory {
    func create(user: User) -> ProfileViewController {
        ProfileViewController(user)
    }
}

class ProfileViewController: UIViewController {

    // MARK: - Data

    private let data: [ProfileViewModelItem] = {
        let images = GetPhotos.shared.getImages().take(4)
        let photosViewModelItems: [PhotosViewModelItem] = [PhotosViewModelItem(images: images)]

        let posts = GetPosts.fetch()
        let postViewModels = posts.map(PostViewModelItem.fromPost)

        return photosViewModelItems + postViewModels
    }()

    private let user: User

    // MARK: - Initializers

    init(_ user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
        self.headerView.update(user: user)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Subviews

    private lazy var tableView: UITableView = {
        UITableView(frame: .zero, style: .grouped)
    }()

    private lazy var headerView: ProfileHeaderView = {
        ProfileHeaderView()
    }()

    private lazy var tableFooterView: UIView = {
        UIView()
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        #if DEBUG
            view.backgroundColor = .systemPink
        #else
            view.backgroundColor = .systemBrown
        #endif

        addSubviews()
        setupConstraints()
        tuneTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        hideNavigationBar()
    }

    // MARK: - Private

    private func tuneTableView() {
        tableView.tableFooterView = tableFooterView

        tableView.register(PostTableViewCell.self)
        tableView.register(PhotosTableViewCell.self)

        tableView.dataSource = self
        tableView.delegate = self
    }

    private func addSubviews() {
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.setupConstraints {
            [
                $0.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                $0.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                $0.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            ]
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = data[indexPath.row]
        switch item {
        case let postItem as PostViewModelItem:
            let cell: PostTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.update(postItem)
            return cell
        case let photosItem as PhotosViewModelItem:
            let cell: PhotosTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.update(images: photosItem.images)
            return cell
        default:
            fatalError("Unknown item type")
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            headerView
        } else {
            nil
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        switch item {
        case _ as PhotosViewModelItem:
            navigationController?.pushViewController(PhotosViewController(), animated: true)
        default:
            break
        }
    }
}
