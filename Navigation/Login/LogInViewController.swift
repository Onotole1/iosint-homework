//
//  LogInViewController.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 20.05.2025.
//

import UIKit
import SnapKit

class LogInViewController: UIViewController {
    // MARK: - Константы

    private static let borderWidth: CGFloat = 0.5
    private static let commonSpacing: CGFloat = 16
    private static let borderColor: UIColor = .lightGray

    // MARK: - Внутренние UIView

    private lazy var logoImageView: UIImageView = {
        UIImageView(image: UIImage(named: "VkIcon"))
    }()

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email or phone"
        return setupTextField(textField)
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return setupTextField(textField)
    }()

    private lazy var fieldsSeparator: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = Self.borderColor
        separatorView.heightAnchor.constraint(equalToConstant: Self.borderWidth).isActive = true
        return separatorView
    }()

    private lazy var fieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(fieldsSeparator)
        stackView.addArrangedSubview(passwordTextField)
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.borderWidth = Self.borderWidth
        stackView.layer.borderColor = Self.borderColor.cgColor
        stackView.layer.cornerRadius = 10
        return stackView
    }()

    private lazy var logInButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        let bluePixel = UIImage.init(named: "BluePixel")!
        let bluePixelSemiTransparent = bluePixel.withAlpha(0.8)
        button.setBackgroundImage(bluePixel, for: .normal)
        button.setBackgroundImage(bluePixelSemiTransparent, for: .selected)
        button.setBackgroundImage(bluePixelSemiTransparent, for: .highlighted)
        button.setBackgroundImage(bluePixelSemiTransparent, for: .disabled)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()

        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white

        return scrollView
    }()

    private lazy var contentView: UIView = {
        UIView()
    }()

    private func setupTextField(_ textField: UITextField) -> UITextField {
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.tintColor = UIColor(named: "AccentColor")
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Self.commonSpacing, height: 0))
        textField.leftViewMode = .always
        textField.rightView = textField.leftView
        textField.rightViewMode = .always
        return textField
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        addSubviews()

        setupViews()

        hideKeyboardOnTapOutside()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true

        setupKeyboardObservers()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - SetupViews

    private func addSubviews() {
        [scrollView].forEach { view.addSubview($0) }
        scrollView.addSubview(contentView)
        [logoImageView, fieldsStackView, logInButton].forEach { contentView.addSubview($0) }
    }

    private func setupViews() {
        let imageViewVerticalSpacing: CGFloat = 150
        let logoSize: CGFloat = 100

        logoImageView.snp.makeConstraints { make in
            make.width.equalTo(logoSize)
            make.height.equalTo(logoSize)
            make.top.equalTo(contentView.snp.top).offset(imageViewVerticalSpacing)
            make.centerX.equalTo(view.snp.centerX)
        }

        scrollView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }

        contentView.snp.makeConstraints { make in
            make.leading.equalTo(scrollView.snp.leading)
            make.width.equalTo(scrollView.snp.width)
            make.trailing.equalTo(scrollView.snp.trailing)
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.bottom.equalTo(logInButton.snp.bottom).offset(16)
        }

        fieldsStackView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(imageViewVerticalSpacing)
            make.leading.equalTo(contentView.snp.leading).offset(Self.commonSpacing)
            make.trailing.equalTo(contentView.snp.trailing).offset(-Self.commonSpacing)
            make.height.equalTo(100)
        }

        logInButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(fieldsStackView.snp.bottom).offset(Self.commonSpacing)
            make.leading.equalTo(contentView.snp.leading).offset(Self.commonSpacing)
            make.trailing.equalTo(contentView.snp.trailing).offset(-Self.commonSpacing)
        }
        logInButton.on(.touchUpInside) { [weak self] _ in
            self?.navigateToMain()
        }
    }

    private func navigateToMain() {
        let uitabbarcontroller = UITabBarController()

        let feedViewController = UINavigationController(rootViewController: FeedViewController())
        feedViewController.tabBarItem.image = UIImage(systemName: "house")
        feedViewController.tabBarItem.title = "Feed"

        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
        profileViewController.tabBarItem.image = UIImage(systemName: "person.circle")
        profileViewController.tabBarItem.title = "Profile"

        uitabbarcontroller.viewControllers = [feedViewController, profileViewController]
        uitabbarcontroller.selectedIndex = 1

        AppNavigation.resetToNewRootViewController(uitabbarcontroller)
    }

    private func hideKeyboardOnTapOutside() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default

        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    // MARK: - Actions

    @objc func willShowKeyboard(_ notification: NSNotification) {
        guard let keyboardSize = (
            notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        )?.cgRectValue else { return }

        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height - tabBarHeight, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func willHideKeyboard(_ notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
