//
//  Planet.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 21.09.2025.
//

struct Planet: Decodable {
    let name: String
    let rotationPeriod: String
    let residents: [String]

    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case residents
    }
}
