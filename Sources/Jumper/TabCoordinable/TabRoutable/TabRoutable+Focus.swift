// Copyright (c) 2022 iDevs.io. All rights reserved.

import Foundation

extension TabRoutable {
    internal func focus(to screen: ScreenView) {
        tabController.selectedViewController = screen
    }
}
