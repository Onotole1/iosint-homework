//
//  FeedViewController.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 11.05.2025.
//

import UIKit

class FeedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let postButton = UIButton(type: .system)
        postButton.setTitle("To post", for: .normal)
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        postButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(postButton)
        
        NSLayoutConstraint.activate([
            postButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            postButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc func didTapPostButton() {
        let post = Post(title: "Test post")
        navigationController?.pushViewController(PostViewController(post: post), animated: true)
    }
}
