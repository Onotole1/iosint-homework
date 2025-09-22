//
//  PlanetViewModel.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 22.09.2025.
//
import Foundation
import Combine

class PlanetViewModel: PlanetViewOutput {
    private var tasks: [Task<Void, Never>] = []

    private let decoder = JSONDecoder()

    @Published private var _state: PlanetLoadableData = PlanetLoadableData()
    var state: AnyPublisher<PlanetLoadableData, Never> {
        $_state.eraseToAnyPublisher()
    }

    var onLoadAction: () -> Void {
        { [weak self] in
            self?.loadPlanet()
        }
    }

    var onLoadPersonAction: (URL) -> Void {
        { [weak self] url in
            self?.load(personUrl: url)
        }
    }

    private func loadPlanet() {
        tasks.forEach { $0.cancel() }
        tasks.removeAll()

        Task {
            let result = await URLSession.shared.downloadData(from: URL(string: "https://swapi.dev/api/planets/1"))
                .flatMap { data -> Result<Planet, NetworkError> in
                    do {
                        return .success(try decoder.decode(Planet.self, from: data.data))
                    } catch {
                        return .failure(NetworkError.decodingError(error))
                    }
                }
                .map { PlanetState.from(planet: $0) }

            await MainActor.run {
                switch result {
                case .success(let planet):
                    _state = _state.toSuccess(planet)
                    planet.residents.forEach { load(personUrl: $0.url) }
                case .failure(let error):
                    _state = _state.toError(error)
                }
            }
        }.appendTo(&tasks)
    }

    private func load(personUrl: URL) {
        Task {
            let updateResidentByUrl = { (update: ((PersonLoadableData) -> PersonLoadableData)) in
                self.updateResident(by: personUrl, update: update)
            }

            await MainActor.run {
                updateResidentByUrl { $0.toLoading() }
            }

            let result = await URLSession.shared.downloadData(from: personUrl)
                .flatMap { data -> Result<Person, NetworkError> in
                    do {
                        return .success(try decoder.decode(Person.self, from: data.data))
                    } catch {
                        return .failure(NetworkError.decodingError(error))
                    }
                }

            await MainActor.run {
                switch result {
                case .success(let planet):
                    updateResidentByUrl { $0.toSuccess(planet) }
                case .failure(let error):
                    updateResidentByUrl { $0.toError(error) }
                }
            }
        }.appendTo(&tasks)
    }

    private func updateResident(by personUrl: URL, update: (PersonLoadableData) -> PersonLoadableData) {
        self._state = self._state.map {
            $0.updateResident(by: personUrl, update: update)
        }
    }
}
