//
//  TestUserService.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 14.07.2025.
//

import UIKit

class TestUserService: UserService {
    let user = User(
        login: "test",
        fullName: "John Doe",
        avatar: UIImage(systemName: "person.circle")!,
        status: "Hello Test",
    )
}
