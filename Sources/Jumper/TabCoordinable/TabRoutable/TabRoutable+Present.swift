// Copyright (c) 2022 iDevs.io. All rights reserved.

import Foundation

extension TabRoutable {
    internal func present(_ screen: ScreenViewPresentable, animated: Bool) {
        let controller = screen.view()
        tabController.present(
            controller,
            animated: animated,
            completion: nil
        )
        controller.presentationController?.delegate = self
    }
}
