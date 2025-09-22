//
//  Person.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 21.09.2025.
//

struct Person: Decodable {
    var name: String
}

typealias PersonLoadableData = ReloadableData<Person, NetworkError>
