//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 11.05.2025.
//

import UIKit

class ProfileViewController: UIViewController {

    private lazy var profileHeaderView = {
        ProfileHeaderView()
    }()

    private lazy var changeTitleButton = {
        let button = UIButton(type: .system)
        button.setTitle( "Change title", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"
        view.backgroundColor = .lightGray

        [profileHeaderView, changeTitleButton].forEach { view.addSubview($0) }

        profileHeaderView.setupConstraints {
            [
                $0.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                $0.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                $0.heightAnchor.constraint(equalToConstant: 220)
            ]
        }

        changeTitleButton
            .setupConstraints {
                [
                    $0.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                    $0.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                    $0.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
                ]
            }
            .on(.touchUpInside) { [weak self] _ in
                self?.title = "New title"
            }

    }
}
