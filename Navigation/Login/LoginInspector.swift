//
//  LoginInspector.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 16.07.2025.
//

class LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        Checker.shared.check(login: login, password: password)
    }
}
