// Copyright (c) 2022 iDevs.io. All rights reserved.

import Foundation

extension NavigationRoutable {
    internal func pop(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
    
    internal func popToRoot(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    internal func pop(to screen: ScreenView, animated: Bool) {
        navigationController.popToViewController(screen, animated: animated)
    }
}
