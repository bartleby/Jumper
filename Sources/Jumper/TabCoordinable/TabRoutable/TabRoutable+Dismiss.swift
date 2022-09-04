// Copyright (c) 2022 iDevs.io. All rights reserved.

import Foundation

extension TabRoutable {
    internal func dismiss(animated: Bool, completion: (() -> Void)?) {
        tabController.dismiss(animated: animated, completion: completion)
    }
}
