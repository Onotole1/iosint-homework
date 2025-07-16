//
//  MyLoginFactory.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 16.07.2025.
//

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
}
