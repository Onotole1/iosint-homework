//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 11.05.2025.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Data

    private let data = GetPosts.fetch()

    // MARK: - Subviews

    private lazy var tableView: UITableView = {
        UITableView()
    }()

    private lazy var headerView: ProfileHeaderView = {
        ProfileHeaderView()
    }()

    private lazy var tableFooterView: UIView = {
        UIView()
    }()

    // MARK: - Cell Ids

    private enum CellReuseID: String {
        case post = "PostTableViewCell_ReuseID"
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        setupConstraints()
        tuneTableView()
    }

    // MARK: - Private

    private func tuneTableView() {
        tableView.setAndLayout(headerView: headerView)
        tableView.tableFooterView = tableFooterView

        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.post.rawValue
        )

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
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseID.post.rawValue,
            for: indexPath
        ) as? PostTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }

        cell.update(data[indexPath.row])

        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {}
