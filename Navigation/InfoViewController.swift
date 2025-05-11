//
//  InfoViewController.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 11.05.2025.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let alertButton = UIButton(type: .system)
        alertButton.setTitle("Alert", for: .normal)
        alertButton.addTarget(self, action: #selector(didTapAlertButton), for: .touchUpInside)
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .systemBackground
        view.addSubview(alertButton)
        
        NSLayoutConstraint.activate([
            alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc func didTapAlertButton() {
        let alert = UIAlertController(title: "Additional info", message: "Very long text", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            print("OK pressed")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            print("Cancel pressed")
        }))
        
        present(alert, animated: true)
    }
}
