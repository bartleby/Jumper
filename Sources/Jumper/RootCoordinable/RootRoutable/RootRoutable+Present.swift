// Copyright (c) 2022 iDevs.io. All rights reserved.

import Foundation

extension RootRoutable {
    internal func present(_ screen: ScreenViewPresentable) {
        present(screen, animated: true)
    }
    
    internal func present(_ screen: ScreenViewPresentable, animated: Bool) {
        let controller = screen.view()
        rootController.present(
            controller,
            animated: animated,
            completion: nil
        )
        controller.presentationController?.delegate = self
    }
}
