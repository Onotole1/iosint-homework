//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 11.05.2025.
//

import UIKit
import Combine

protocol ProfileViewControllerFactory {
    func create(user: User) -> ProfileViewController
}

class ProfileViewControllerFactoryImpl: ProfileViewControllerFactory {
    private let profileViewOutputFactory: ProfileViewOutputFactory

    init(profileViewOutputFactory: ProfileViewOutputFactory) {
        self.profileViewOutputFactory = profileViewOutputFactory
    }

    func create(user: User) -> ProfileViewController {
        ProfileViewController(profileViewOutputFactory.makeOutput(user: user))
    }
}

class ProfileViewController: UIViewController {

    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Data
    private var items: [ProfileViewModelItem] = []

    // MARK: - ViewModel

    private let viewOutput: ProfileViewOutput

    // MARK: - Initializers

    init(_ viewOutput: ProfileViewOutput) {
        self.viewOutput = viewOutput
        super.init(nibName: nil, bundle: nil)
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
        bindView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        hideNavigationBar()
    }

    // MARK: - Private

    private func bindView() {
        viewOutput.config.sink { [weak self] config in
            guard let self else { return }
            headerView.update(user: config.user)
            items = config.items
            tableView.reloadData()
        }
        .store(in: &cancellables)

        headerView.onStatusSet = { [weak self] status in
            self?.viewOutput.onSetStatusAction(status)
        }
    }

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
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
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
        let item = items[indexPath.row]
        switch item {
        case _ as PhotosViewModelItem:
            navigationController?.pushViewController(PhotosViewController(), animated: true)
        default:
            break
        }
    }
}
