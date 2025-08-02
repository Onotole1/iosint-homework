//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 02.08.2025.
//
import Combine

protocol ProfileViewOutput {
    var config: AnyPublisher<ProfileViewConfig, Never> { get }
}
