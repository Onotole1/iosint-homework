//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 13.05.2025.
//

import UIKit
import SnapKit

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

        closeButton.snp.makeConstraints { make in
            make.top.equalTo(window.safeAreaLayoutGuide.snp.top).offset(commonSpacing)
            make.trailing.equalTo(window.safeAreaLayoutGuide.snp.trailing).offset(-commonSpacing)
            make.width.equalTo(closeButtonSize)
            make.height.equalTo(closeButtonSize)
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
        imageView.image = UIImage(named: "Mura")
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
        titleLabel.text = "Banana Cat"
        return titleLabel
    }()

    private lazy var setStatusButton: UIButton = {
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

    private lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.font = .systemFont(ofSize: 14, weight: .regular)
        statusLabel.textColor = .gray
        statusLabel.textAlignment = .left
        statusLabel.text = "Hello, world!"
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
        statusTextField.snp.makeConstraints { make in
            make.leading.equalTo(statusLabel.snp.leading)
            make.top.equalTo(statusLabel.snp.bottom).offset(8)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-Self.commonSpacing)
            make.height.equalTo(40)
        }

        statusTextField.on(.editingChanged) { [weak self] (textField: UITextField) in
            self?.statusText = textField.text ?? ""
        }
    }

    private func setupSetStatusButton() {
        setStatusButton.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(Self.commonSpacing)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-Self.commonSpacing)
            make.top.equalTo(statusTextField.snp.bottom).offset(Self.commonSpacing)
            make.height.equalTo(50)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }

        setStatusButton.on(.touchUpInside) { [weak self] _ in
            guard let self else { return }
            self.statusLabel.text = self.statusText
        }
    }

    private func setupFullNameLabel() {
        fullNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(27)
        }
    }

    private func setupAvatarImageView() {
        avatarImageView.snp.makeConstraints { make in
            make.width.equalTo(Self.avatarSize)
            make.height.equalTo(Self.avatarSize)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(Self.commonSpacing)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(Self.commonSpacing)
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        avatarImageView.addGestureRecognizer(tapGesture)
    }

    private func setupStatusLabel() {
        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(fullNameLabel.snp.leading)
            make.top.equalTo(fullNameLabel.snp.bottom).offset(34)
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
