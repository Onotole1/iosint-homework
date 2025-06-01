//
//  GetPhotos.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 02.06.2025.
//

struct GetPhotos {
    static func fetch() -> [String] {
        [
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
            .shuffled()
    }
}
