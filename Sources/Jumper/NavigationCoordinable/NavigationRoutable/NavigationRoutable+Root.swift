// Copyright (c) 2022 iDevs.io. All rights reserved.

import UIKit

extension NavigationRoutable {
    internal func setRoot(_ screen: ScreenViewPresentable, animated: Bool) {
        let viewController = screen.view()
        navigationController.setViewControllers([viewController], animated: animated)
    }
}
