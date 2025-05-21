//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 13.05.2025.
//

import UIKit

class ProfileHeaderView: UIView {
    // MARK: - Константы
    private static let commonSpacing = 16.0
    private static let avatarSize: CGFloat = 100
    
    private var statusText = "Listening to music"
    
    // MARK: - Внутренние UIView
    private let avatar = {
        let imageRect = CGRect(x: 0, y: 0, width: avatarSize, height: avatarSize)
        let imageView = UIImageView(frame: imageRect)
        imageView.image = UIImage(named: "Mura")
        imageView.layer.cornerRadius = avatarSize / 2
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.text = "Banana Cat"
        return titleLabel
    }()
    
    private let showStatusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.masksToBounds = false
        button.setTitle("Set status", for: .normal)
        return button
    }()
    
    private let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.font = .systemFont(ofSize: 14, weight: .regular)
        statusLabel.textColor = .gray
        statusLabel.textAlignment = .left
        return statusLabel
    }()
    
    private let statusTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.placeholder = "Enter status..."
        textField.backgroundColor = .white
        textField.isUserInteractionEnabled = true
        
        let horizontalSpacing = 8.0
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: horizontalSpacing, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: horizontalSpacing, height: textField.frame.height))
        textField.rightViewMode = .always
    
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        
        return textField
    }()

    // MARK: - Инициализаторы
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Настройка вьюшек
    private func setupView() {
        [avatar, titleLabel, showStatusButton, statusLabel, statusTextField].forEach { addSubview($0) }
        
        setupConstraints()
        
        statusLabel.text = statusText
        statusTextField.text = statusText
        
        setupListeners()
    }
    
    // MARK: - Настройка констрейнтов
    private func setupConstraints() {
        titleLabel.setupConstraints { view in
            [
                view.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
                view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            ]
        }
        
        avatar.setupConstraints { view in
            [
                view.widthAnchor.constraint(equalToConstant: Self.avatarSize),
                view.heightAnchor.constraint(equalToConstant: Self.avatarSize),
                view.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Self.commonSpacing),
                view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Self.commonSpacing),
            ]
        }
        
        showStatusButton.setupConstraints { view in
            [
                view.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Self.commonSpacing),
                view.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Self.commonSpacing),
                view.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: Self.commonSpacing),
                view.heightAnchor.constraint(equalToConstant: 50),
            ]
        }
        
        statusLabel.setupConstraints { view in
            [
                view.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 34),
            ]
        }
        
        statusTextField.setupConstraints { view in
            [
                view.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
                view.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 8),
                view.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Self.commonSpacing),
                view.heightAnchor.constraint(equalToConstant: 40),
            ]
        }
    }
    
    // MARK: - Установка обработчиков
    private func setupListeners() {
        showStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        statusTextField.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
    }
    
    // MARK: - Обработчики
    @objc private func buttonPressed() {
        self.statusLabel.text = statusText
    }
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }
}
