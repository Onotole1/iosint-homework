//
//  ProfileViewConfig.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 02.08.2025.
//

struct ProfileViewConfig {
    let user: User
    let items: [ProfileViewModelItem]

    func updateStatus(_ newStatus: String) -> ProfileViewConfig {
        ProfileViewConfig(user: user.updateStatus(newStatus), items: items)
    }
}
