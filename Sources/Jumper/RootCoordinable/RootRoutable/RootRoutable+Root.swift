// Copyright (c) 2022 iDevs.io. All rights reserved.

import Foundation

extension RootRoutable {
    internal func setRoot(_ screen: ScreenViewPresentable) {
        clearRoot()
        let controller = screen.view()
        controller.willMove(toParent: rootController)
        rootController.addChild(controller)
        rootController.view.addSubview(controller.view)
        controller.didMove(toParent: rootController)
    }
}

extension RootRoutable {
    internal func clearRoot() {
        rootController.children.forEach {
            presentationControllerDidDismiss?($0)
            $0.removeFromParent()
        }
        rootController.view.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
}
