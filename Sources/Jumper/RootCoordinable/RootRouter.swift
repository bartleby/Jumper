// Copyright (c) 2022 iDevs.io. All rights reserved.

import UIKit

internal class RootRouter: NSObject, RootRoutable {
    internal var rootController: ScreenView
    internal var presentationControllerDidDismiss: ((ScreenView) -> Void)?
    
    internal init(rootController: ScreenView = ScreenView()) {
        self.rootController = rootController
    }
}

extension RootRouter {
    internal func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        presentationControllerDidDismiss?(presentationController.presentedViewController)
    }
}
