//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 11.05.2025.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Data

    private let data: [ProfileViewModelItem] = [PhotosViewModelItem()] + GetPosts.fetch()
        .map(PostViewModelItem.fromPost)

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
        case _ as PhotosViewModelItem:
            return tableView.dequeueReusableCell(for: indexPath) as PhotosTableViewCell
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
