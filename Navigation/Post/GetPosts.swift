//
//  GetPosts.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 21.05.2025.
//

import Foundation

struct GetPosts {
    static func fetch() -> [Post] {
        [
            Post(
                author: "Alice Johnson",
                description: "Первый пост о новых тенденциях в технологиях. Будьте в курсе всех новинок!",
                likes: 50,
                views: 200,
                image: "trends",
            ),
            Post(
                author: "Bob Brown",
                description: "Советы по путешествиям: как спланировать идеальный отпуск. Делюсь опытом!",
                likes: 75,
                views: 150,
                image: "vacation",
            ),
            Post(
                author: "Charlie Lee",
                description: "Рецепты домашней кухни: легкий и вкусный ужин за 30 минут. Попробуйте сами!",
                likes: 100,
                views: 300,
                image: "dinner",
            ),
            Post(
                author: "David Williams",
                description: "История успеха: как я запустил свой стартап и добился признания. Все подробности здесь!",
                likes: 85,
                views: 250,
                image: "startup",
            ),
            Post(
                author: "Emily Mitchell",
                description: """
                Тренды в моде на 2023 год: что будет в моде и как создать стильный образ.
                Узнайте первыми!
                """,
                likes: 90,
                views: 220,
                image: "fashion",
            ),
        ]
    }
}
