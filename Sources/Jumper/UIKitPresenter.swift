// Copyright (c) 2024 iDevs.io. All rights reserved.

import UIKit
import SwiftUI

public protocol UIKitPresenter {
    func present(_ viewController: UIViewController, animated: Bool)
    func dismiss(animated: Bool)
    func presentAlert(title: String, message: String)
}

public struct UIKitPresenterKey: EnvironmentKey {
    public static let defaultValue: UIKitPresenter? = nil
}

extension EnvironmentValues {
    public var uiKitPresenter: UIKitPresenter? {
        get { self[UIKitPresenterKey.self] }
        set { self[UIKitPresenterKey.self] = newValue }
    }
} 