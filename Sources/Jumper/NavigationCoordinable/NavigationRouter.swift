// Copyright (c) 2022 iDevs.io. All rights reserved.

import UIKit

internal class NavigationRouter: NSObject, NavigationRoutable {
    internal var navigationController: UINavigationController
    internal var presentationControllerDidDismiss: ((ScreenView) -> Void)?
    internal var popViewControllerTo: ((ScreenView) -> Void)?
    
    internal init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
    }
}

extension NavigationRouter {
    internal func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        presentationControllerDidDismiss?(presentationController.presentedViewController)
    }
}

extension NavigationRouter {
    internal func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        guard
            let fromViewController = navigationController
            .transitionCoordinator?
            .viewController(forKey: .from),
            let toViewController = navigationController
                .transitionCoordinator?
                .viewController(forKey: .to),
              !navigationController.viewControllers.contains(fromViewController),
            toViewController != navigationController.presentedViewController
        else { return }
        popViewControllerTo?(viewController)
    }
}
