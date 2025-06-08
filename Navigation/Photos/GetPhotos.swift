//
//  GetPhotos.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 02.06.2025.
//
import UIKit

struct GetPhotos {
    static let shared = GetPhotos()

    private init() {
        // Инициализация кэша при создании синглтона
        self.images = [
            "castle_1",
            "castle_2",
            "castle_3",
            "castle_4",
            "dragon_1",
            "dragon_2",
            "dragon_3",
            "dragon_4",
            "fish_1",
            "fish_2",
            "fish_3",
            "fish_4",
            "graphs_1",
            "graphs_2",
            "graphs_3",
            "graphs_4",
            "vegetables_1",
            "vegetables_2",
            "vegetables_3",
            "vegetables_4",
        ]
        .map { UIImage(named: $0)! }
        .shuffled()
    }

    private let images: [UIImage]

    func getImages() -> [UIImage] {
        return images
    }
}
