//
//  PostViewModelItem.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 01.06.2025.
//

struct PostViewModelItem: ProfileViewModelItem {
    static func fromPost(_ post: Post) -> PostViewModelItem {
        .init(
            author: post.author,
            description: post.description,
            likes: post.likes,
            views: post.views,
            image: post.image
        )
    }

    let author: String
    let description: String
    let likes: Int
    let views: Int
    let image: String
}
