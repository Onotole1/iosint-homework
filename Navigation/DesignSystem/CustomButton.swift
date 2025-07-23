//
//  CustomButton.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 18.07.2025.
//
import UIKit

class CustomButton: UIButton {
    static func make(
        buttonType: UIButton.ButtonType,
        title: String? = nil,
        titleColor: UIColor? = nil,
        buttonTapped: @escaping () -> Void,
    ) -> CustomButton {
        let button = CustomButton.init(type: .system)

        title.map { button.setTitle($0, for: .normal) }
        titleColor.map { button.setTitleColor($0, for: .normal) }
        button.on(.touchUpInside) { _ in
            buttonTapped()
        }

        return button
    }
}
