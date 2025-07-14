//
//  UserService.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 13.07.2025.
//

protocol UserService {
    var user: User { get }
    func auth(login: String) -> User?
}

extension UserService {
    func auth(login: String) -> User? {
        login == user.login ? user : nil
    }
}
