//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 13.05.2025.
//

import UIKit

class ProfileHeaderView: UIView {
    // MARK: - Константы

    private static let avatarAnimationDuration: TimeInterval = 0.3
    private static let closeButtonAnimationDuration: TimeInterval = 0.3
    private static let commonSpacing = 16.0
    private static let avatarSize: CGFloat = 100
    private static let avatarCornerRadius: CGFloat = avatarSize / 2

    private static func createOverlayView(window: UIWindow) -> UIView {
        let overlay = UIView()
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        overlay.alpha = 0
        window.addSubview(overlay)
        overlay.frame = window.bounds
        return overlay
    }

    private static func createCloseButton(window: UIWindow) -> UIButton {
        let closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        closeButton.tintColor = .white
        closeButton.isUserInteractionEnabled = true
        closeButton.alpha = 0
        window.addSubview(closeButton)
        let closeButtonSize = 44.0
        closeButton.setupConstraints {
            [
                $0.topAnchor.constraint(equalTo: window.safeAreaLayoutGuide.topAnchor, constant: commonSpacing),
                $0.trailingAnchor.constraint(
                    equalTo: window.safeAreaLayoutGuide.trailingAnchor,
                    constant: -commonSpacing,
                ),
                $0.widthAnchor.constraint(equalToConstant: closeButtonSize),
                $0.heightAnchor.constraint(equalToConstant: closeButtonSize),
            ]
        }
        return closeButton
    }

    private static func createAvatarTargetRect(window: UIWindow) -> CGRect {
        let screenWidth = window.bounds.width
        let newHeight = screenWidth
        let newX = 0.0
        let newY = (window.bounds.height - newHeight) / 2
        return CGRect(x: newX, y: newY, width: screenWidth, height: newHeight)
    }

    // MARK: - Дополнительные свойства
    private var originalAvatarFrame: CGRect?
    private var isAvatarExpanded = false
    private var statusText = ""

    private weak var overlayView: UIView?
    private weak var closeButton: UIButton?

    // MARK: - Внутренние UIView

    private lazy var avatarImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = Self.avatarCornerRadius
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var fullNameLabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.text = ""
        return titleLabel
    }()

    private lazy var setStatusButton: UIButton = {
        let button = CustomButton.make(
            buttonType: .custom,
            title: "Set status",
            titleColor: .white
        ) { [weak self] in
            guard let self else { return }
            self.statusLabel.text = self.statusText
        }
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.masksToBounds = false
        return button
    }()

    private lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.font = .systemFont(ofSize: 14, weight: .regular)
        statusLabel.textColor = .gray
        statusLabel.textAlignment = .left
        return statusLabel
    }()

    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.placeholder = "Enter status..."
        textField.backgroundColor = .white
        textField.isUserInteractionEnabled = true

        let horizontalSpacing = 8.0
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: horizontalSpacing, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.rightView = UIView(
            frame: CGRect(x: 0, y: 0, width: horizontalSpacing, height: textField.frame.height)
        )
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

    // MARK: - Обновление вьюшек
    func update(user: User) {
        statusTextField.text = user.status
        statusText = user.status
        statusLabel.text = user.status
        fullNameLabel.text = user.fullName
        avatarImageView.image = user.avatar
    }

    // MARK: - Настройка вьюшек

    private func setupView() {
        addSubviews()

        setupSubviews()
    }

    private func addSubviews() {
        [avatarImageView, fullNameLabel, setStatusButton, statusLabel, statusTextField].forEach { addSubview($0) }
    }

    private func setupSubviews() {
        setupFullNameLabel()
        setupAvatarImageView()
        setupSetStatusButton()
        setupStatusLabel()
        setupStatusTextField()
    }

    private func setupStatusTextField() {
        statusTextField.setupConstraints {
            [
                $0.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
                $0.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 8),
                $0.trailingAnchor
                    .constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Self.commonSpacing),
                $0.heightAnchor.constraint(equalToConstant: 40),
            ]
        }
        .on(.editingChanged) { [weak self] (textField: UITextField) in
            self?.statusText = textField.text ?? ""
        }
    }

    private func setupSetStatusButton() {
        setStatusButton.setupConstraints {
            [
                $0.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Self.commonSpacing),
                $0.trailingAnchor
                    .constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Self.commonSpacing),
                $0.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: Self.commonSpacing),
                $0.heightAnchor.constraint(equalToConstant: 50),
                $0.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            ]
        }
    }

    private func setupFullNameLabel() {
        fullNameLabel.setupConstraints {
            [
                $0.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
                $0.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            ]
        }
    }

    private func setupAvatarImageView() {
        avatarImageView.setupConstraints {
            [
                $0.widthAnchor.constraint(equalToConstant: Self.avatarSize),
                $0.heightAnchor.constraint(equalToConstant: Self.avatarSize),
                $0.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Self.commonSpacing),
                $0.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Self.commonSpacing),
            ]
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        avatarImageView.addGestureRecognizer(tapGesture)
    }

    private func setupStatusLabel() {
        statusLabel.setupConstraints {
            [
                $0.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
                $0.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 34),
            ]
        }
    }

    // MARK: - Анимации

    @objc private func avatarTapped() {
        guard !isAvatarExpanded, let window else { return }
        isAvatarExpanded = true

        originalAvatarFrame = avatarImageView.frame

        let overlay = Self.createOverlayView(window: window)
        self.overlayView = overlay

        let closeButton = Self.createCloseButton(window: window)
        closeButton.on(.touchUpInside) { _ in
            self.closeTapped()
        }
        self.closeButton = closeButton

        moveAvatarToWindow(window)

        UIView.animate(withDuration: Self.avatarAnimationDuration, animations: {
            self.avatarImageView.frame = Self.createAvatarTargetRect(window: window)
            self.avatarImageView.layer.cornerRadius = 0
            overlay.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: Self.closeButtonAnimationDuration) {
                closeButton.alpha = 1
            }
        })

        window.bringSubviewToFront(avatarImageView)
        window.bringSubviewToFront(closeButton)
    }

    private func moveAvatarToWindow(_ window: UIWindow) {
        let avatarFrameInWindow = convert(avatarImageView.frame, to: window)
        avatarImageView.removeFromSuperview()
        avatarImageView.translatesAutoresizingMaskIntoConstraints = true
        window.addSubview(avatarImageView)
        avatarImageView.frame = avatarFrameInWindow
    }

    private func closeTapped() {
        guard isAvatarExpanded, let originalAvatarFrame, let window else { return }

        UIView.animate(withDuration: Self.closeButtonAnimationDuration, animations: {
            self.closeButton?.alpha = 0
        }, completion: { _ in
            UIView.animate(withDuration: Self.avatarAnimationDuration, animations: {
                self.avatarImageView.frame = self.convert(originalAvatarFrame, to: window)
                self.avatarImageView.layer.cornerRadius = Self.avatarCornerRadius
                self.overlayView?.alpha = 0
            }, completion: { _ in
                self.avatarImageView.removeFromSuperview()
                self.addSubview(self.avatarImageView)
                self.avatarImageView.frame = originalAvatarFrame
                self.setupAvatarImageView()

                self.overlayView?.removeFromSuperview()
                self.closeButton?.removeFromSuperview()
                self.isAvatarExpanded = false
            })
        })
    }
}
