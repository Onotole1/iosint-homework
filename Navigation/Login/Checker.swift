//
//  Untitled.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 16.07.2025.
//

class Checker {
    static let shared = Checker()

    private static let login = "login"
    private static let password = "password"

    private init() {}

    func check(login: String, password: String) -> Bool {
        Self.login == login && Self.password == password
    }
}
