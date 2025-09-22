//
//  PlanetViewOutput.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 22.09.2025.
//
import Foundation
import Combine

protocol PlanetViewOutput {
    var state: AnyPublisher<PlanetLoadableData, Never> { get }
    var onLoadAction: (() -> Void) { get }
    var onLoadPersonAction: ((URL) -> Void) { get }
}
