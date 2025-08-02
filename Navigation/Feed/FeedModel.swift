//
//  FeedModel.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 24.07.2025.
//
import Combine

protocol FeedModel {
    var checkWordResult: AnyPublisher<CheckWordResult, Never> { get }

    func check(word: String)
}

class FeedModelImpl: FeedModel {
    @Published private var _checkWordResult: CheckWordResult = .incorrect
    var checkWordResult: AnyPublisher<CheckWordResult, Never> {
        $_checkWordResult.eraseToAnyPublisher()
    }
    private let secretWord: String

    init(secretWord: String) {
        self.secretWord = secretWord.lowercased()
    }

    func check(word: String) {
        _checkWordResult = word.lowercased() == secretWord ? .correct : .incorrect
    }
}
