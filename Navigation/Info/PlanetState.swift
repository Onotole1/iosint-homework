//
//  InfoState.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 21.09.2025.
//
import Foundation

struct PlanetState {
    var planetName: String = ""
    var rotationPeriod: String = ""
    var residents: [ResidentState] = []

    func updateResident(by url: URL, update: (PersonLoadableData) -> PersonLoadableData) -> PlanetState {
        if let index = residents.firstIndex(where: { $0.url == url }) {
            var copy = self
            copy.residents[index] = ResidentState(url: url, person: update(residents[index].person))
            return copy
        } else {
            return self
        }
    }

    static func from(planet: Planet) -> Self {
        .init(
            planetName: planet.name,
            rotationPeriod: planet.rotationPeriod,
            residents: planet.residents.compactMap {
                URL(string: $0)
            }
                .map {
                    ResidentState(url: $0)
                }
        )
    }
}

typealias PlanetLoadableData = ReloadableData<PlanetState, NetworkError>
