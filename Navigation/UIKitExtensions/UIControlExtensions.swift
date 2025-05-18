//
//  UIControlExtensions.swift
//  Navigation
//
//  Created by Анатолий Спитченко on 18.05.2025.
//

import UIKit

extension UIControl {
    // В проекте ограничение минимальной версии iOS 13 и нельзя использовать addAction,
    // а хочется просто closure передавать и чтобы поддержка цепочек была бонусом
    @discardableResult
    func on<T: UIControl>(_ controlEvents: UIControl.Event, action: @escaping (T) -> Void) -> T {
        let actionHandler = ActionHandler(action: { [weak self] in
            guard let self = self else { return }
            // swiftlint:disable force_cast
            action(self as! T)
            // swiftlint:enable force_cast
        })
        self.addTarget(actionHandler, action: #selector(ActionHandler.performAction), for: controlEvents)
        let keyString = "actionHandler_\(controlEvents.rawValue)"
        let key = UnsafeMutableRawPointer(bitPattern: keyString.hashValue)!
        objc_setAssociatedObject(self, key, actionHandler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        // swiftlint:disable force_cast
        return self as! T
        // swiftlint:enable force_cast
    }
}

private class ActionHandler: NSObject {
    let action: () -> Void

    init(action: @escaping () -> Void) {
        self.action = action
    }

    @objc func performAction() {
        action()
    }
}
