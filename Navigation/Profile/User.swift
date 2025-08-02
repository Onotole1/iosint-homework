//
//  User.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 13.07.2025.
//
import UIKit

struct User {
    let login: String
    let fullName: String
    let avatar: UIImage
    let status: String

    func updateStatus(_ newStatus: String) -> User {
        User(login: login, fullName: fullName, avatar: avatar, status: newStatus)
    }
}
