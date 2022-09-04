// Copyright (c) 2022 iDevs.io. All rights reserved.

import UIKit

extension NavigationRoutable {
    internal func dismiss(animated: Bool) {
        dismiss(animated: animated, completion: nil)
    }
    
    internal func dismiss(animated: Bool, completion: (() -> Void)?) {
        navigationController.dismiss(animated: animated, completion: completion)
    }
}
