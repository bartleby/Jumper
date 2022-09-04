// Copyright (c) 2022 iDevs.io. All rights reserved.

import UIKit

internal class TabRouter: NSObject, TabRoutable {
    internal var tabController: UITabBarController
    internal var presentationControllerDidDismiss: ((ScreenView) -> Void)?
    
    internal init(tabController: UITabBarController = UITabBarController()) {
        self.tabController = tabController
    }
}

extension TabRouter {
    internal func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        presentationControllerDidDismiss?(presentationController.presentedViewController)
    }
}
