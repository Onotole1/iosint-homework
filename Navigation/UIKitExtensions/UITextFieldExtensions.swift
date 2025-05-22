//
//  UITextFieldExtensions.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 18.05.2025.
//

import UIKit

extension UITextField {
    @discardableResult
    func setText(_ text: String?) -> Self {
        self.text = text
        return self
    }
}
