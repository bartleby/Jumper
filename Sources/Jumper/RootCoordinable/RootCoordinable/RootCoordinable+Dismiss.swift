// Copyright (c) 2022 iDevs.io. All rights reserved.

import Foundation

extension RootCoordinable {
    public func dismissChild<T>(coordinator: T, action: (() -> Void)?) where T : Coordinable {
        navigation.router.dismiss(animated: true, completion: action)
        if let index = children.firstIndex(where: { $0.coordinator === coordinator }) {
            children.remove(at: index)
        }
    }
    
    public func dismiss(_ action: (() -> Void)? = nil) {
        parent?.dismissChild(coordinator: self, action: action)
    }
}
