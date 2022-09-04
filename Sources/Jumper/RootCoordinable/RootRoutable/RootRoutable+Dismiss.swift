// Copyright (c) 2022 iDevs.io. All rights reserved.

import Foundation

extension RootRoutable {
    internal func dismiss(animated: Bool, completion: (() -> Void)?) {
        rootController.dismiss(animated: animated, completion: completion)
    }
}
