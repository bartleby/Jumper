// Copyright (c) 2022 iDevs.io. All rights reserved.

import UIKit

extension NavigationRoutable {
    internal func present(_ screen: ScreenViewPresentable, animated: Bool) {
        let controller = screen.view()
        navigationController.present(
            controller,
            animated: animated,
            completion: nil
        )
        controller.presentationController?.delegate = self
    }
}
