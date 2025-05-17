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

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"
        view.backgroundColor = .lightGray
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(profileHeaderView)
        profileHeaderView.frame = view.frame
    }
}
