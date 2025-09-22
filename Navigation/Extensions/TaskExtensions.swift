//
//  TaskExtensions.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 22.09.2025.
//
import Foundation

extension Task {
    // Метод для добавления задачи в массив
    func appendTo(_ tasks: inout [Task<Success, Failure>]) {
        tasks.append(self)
    }
}
