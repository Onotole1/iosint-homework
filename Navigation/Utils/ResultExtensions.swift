//
//  ResultExtensions.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 14.09.2025.
//

extension Result {
    @discardableResult
    func doOnSuccess(_ action: @escaping (Success) -> Void) -> Self {
        if case let .success(value) = self {
            action(value)
        }

        return self
    }

    @discardableResult
    func doOnError(_ action: @escaping (Failure) -> Void) -> Self {
        if case let .failure(error) = self {
            action(error)
        }

        return self
    }
}
