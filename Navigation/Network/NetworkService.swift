//
//  NetworkService.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 13.09.2025.
//
import Foundation

struct NetworkService {
    static func request(for configuration: AppConfiguration) {
        let loader = { (url: URL) async in
            await URLSession.shared.downloadData(from: url)
                .doOnSuccess {
                    print($0.data)
                    if let httpResponse = $0.response as? HTTPURLResponse {
                        print(httpResponse.allHeaderFields)
                        print(httpResponse.statusCode)
                    }
                }
                .doOnError {
                    print($0.localizedDescription)
                }
        }

        Task {
            switch configuration {
            case .planet(let url):
                await loader(url)
            case .species(let url):
                await loader(url)
            case .starship(let url):
                await loader(url)
            }
        }
    }
}
