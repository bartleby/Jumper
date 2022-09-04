// Copyright (c) 2022 iDevs.io. All rights reserved.

import Foundation

extension NavigationCoordinable {
    @discardableResult
    public func pop(animated: Bool = true) -> Self {
        navigation.router.pop(animated: animated)
        return self
    }
    
    @discardableResult
    public func popToRoot(animated: Bool = true) -> Self {
        navigation.router.popToRoot(animated: animated)
        return self
    }
    
    @discardableResult
    public func pop(to route: ScreenRouteKeyPath, animated: Bool = true) -> Self {
        if let child = children.last(where: { $0.routeHash == route.hashValue }) {
            navigation.router.pop(to: child.screenView, animated: animated)
        }
        return self
    }
}
