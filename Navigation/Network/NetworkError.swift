//
//  NetworkError.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 14.09.2025.
//
import Foundation

enum NetworkError: Error {
    case invalidURL
    case networkError(Error)
    case httpError(statusCode: Int)
    case decodingError(Error)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .networkError(let underlyingError):
            return "Network error: \(underlyingError.localizedDescription)"
        case .httpError(statusCode: let code):
            return "HTTP error: \(code)"
        case .decodingError(let underlyingError):
            return "Decoding error: \(underlyingError.localizedDescription)"
        }
    }
}
