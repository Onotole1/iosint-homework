//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 16.07.2025.
//

protocol LoginViewControllerDelegate: AnyObject {
    func check(login: String, password: String) -> Bool
}
