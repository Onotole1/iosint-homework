//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 13.07.2025.
//
import UIKit

class CurrentUserService: UserService {
    let user = User(
        login: "anatolii",
        fullName: "Anatoliy Spitchenko",
        avatar: UIImage(named: "Mura")!,
        status: "Hello World",
    )
}
