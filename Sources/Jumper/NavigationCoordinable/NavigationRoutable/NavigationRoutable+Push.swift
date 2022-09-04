// Copyright (c) 2022 iDevs.io. All rights reserved.

import UIKit

extension NavigationRoutable {    
    internal func push(_ screen: ScreenViewPresentable, animated: Bool) {
        let controller = screen.view()
        guard !(controller is UINavigationController) else {
            return assertionFailure("Can't push UINavigationController to Navigation stack")
        }
        navigationController.pushViewController(controller, animated: animated)
    }
}
