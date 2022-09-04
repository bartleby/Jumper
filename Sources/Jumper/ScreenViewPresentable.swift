// Copyright (c) 2022 iDevs.io. All rights reserved.

import UIKit

public typealias TabBarItem = UITabBarItem
public typealias ScreenView = UIViewController

public protocol ScreenViewPresentable {
    func view() -> ScreenView
}

extension UIViewController: ScreenViewPresentable {
    public func view() -> ScreenView {
        return self
    }
}
