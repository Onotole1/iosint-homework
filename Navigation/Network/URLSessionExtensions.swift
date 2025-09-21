//
//  URLSessionExtensions.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 14.09.2025.
//
import Foundation

extension URLSession {
    func downloadData(from url: URL?) async -> Result<(data: Data, response: URLResponse), NetworkError> {
        guard let validURL = url as URL? else {
            return .failure(.invalidURL)
        }

        do {
            let (data, response) = try await data(from: validURL)

            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                return .failure(.httpError(statusCode: httpResponse.statusCode))
            }

            return .success((data, response))
        } catch {
            return .failure(.networkError(error))
        }
    }
}
