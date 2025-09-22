//
//  ReloadableData.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 21.09.2025.
//

struct ReloadableData<T, Error> {
    var value: T?
    var status: Status<Error> = .idle

    func toLoading() -> Self {
        .init(status: .loading)
    }

    func toError(_ error: Error) -> Self {
        .init(status: .error(error))
    }

    func toSuccess(_ newValue: T) -> Self {
        .init(value: newValue, status: .idle)
    }

    func map<U>(_ transform: (T) -> U) -> ReloadableData<U, Error> {
        .init(value: value.map(transform))
    }

    func mapError<E>(_ transform: (Error) -> E) -> ReloadableData<T, E> {
        switch status {
        case .idle: return ReloadableData<T, E>(status: .idle)
        case .loading: return ReloadableData<T, E>(status: .loading)
        case .error(let error): return ReloadableData<T, E>(status: .error(transform(error)))
        }
    }
}

enum Status<T> {
    case idle
    case loading
    case error(T)
}
