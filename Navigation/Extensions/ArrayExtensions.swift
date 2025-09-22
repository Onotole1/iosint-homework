//
//  ArrayExtensions.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 02.06.2025.
//

import Foundation

extension Array {
    func take(_ first: Int) -> [Element] {
        return Array(self[0..<first])
    }
}
