//
//  NetworkError.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 14.09.2025.
//

enum NetworkError: Error {
    case invalidURL
    case networkError(Error)
    case httpError(statusCode: Int)
}
