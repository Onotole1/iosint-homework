//
//  LogInViewController.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 20.05.2025.
//

import UIKit

class LogInViewController: UIViewController {
    // MARK: - Константы

    private static let borderWidth: CGFloat = 0.5
    private static let commonSpacing: CGFloat = 16
    private static let borderColor: UIColor = .lightGray

    // MARK: - Deleegate

    weak var delegate: LoginViewControllerDelegate?

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
        let button = CustomButton.make(
            buttonType: .custom,
            title: "Log In",
            titleColor: .white
        ) { [weak self] in
            self?.onLoginClicked()
        }
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

    private let coordinator: AppCoordinator
    private let userService: UserService

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

    init(coordinator: AppCoordinator, userService: UserService) {
        self.coordinator = coordinator
        self.userService = userService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        logoImageView.setupConstraints {
            let logoSize: CGFloat = 100
            return [
                $0.widthAnchor.constraint(equalToConstant: logoSize),
                $0.heightAnchor.constraint(equalToConstant: logoSize),
                $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: imageViewVerticalSpacing),
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ]
        }

        scrollView.setupConstraints {
            [
                $0.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                $0.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                $0.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            ]
        }

        contentView.setupConstraints {
            [
                $0.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                $0.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                $0.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                $0.topAnchor.constraint(equalTo: scrollView.topAnchor),
                $0.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                $0.bottomAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16),
            ]
        }

        fieldsStackView.setupConstraints {
            [
                $0.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: imageViewVerticalSpacing),
                $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Self.commonSpacing),
                $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Self.commonSpacing),
                $0.heightAnchor.constraint(equalToConstant: 100),
            ]
        }

        logInButton.setupConstraints {
            [
                $0.heightAnchor.constraint(equalToConstant: 50),
                $0.topAnchor.constraint(equalTo: fieldsStackView.bottomAnchor, constant: Self.commonSpacing),
                $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Self.commonSpacing),
                $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Self.commonSpacing),
            ]
        }
    }

    private func onLoginClicked() {
        guard let delegate = delegate else { fatalError("Delegate not set") }
        if delegate.check(
            login: emailTextField.text ?? "",
            password: passwordTextField.text ?? "",
        ) {
            navigateToMain()
        } else {
            showIncorrectCredentialsAlert()
        }
    }

    private func showIncorrectCredentialsAlert() {
        let alertController = UIAlertController(
            title: "Incorrect credentials",
            message: "Please try again",
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }

    private func navigateToMain() {
        coordinator.showMainScreen()
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
