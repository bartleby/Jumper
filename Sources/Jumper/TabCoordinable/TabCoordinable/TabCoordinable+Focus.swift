// Copyright (c) 2022 iDevs.io. All rights reserved.

import Foundation

extension TabCoordinable {
    @discardableResult
    public func focus(_ route: TabRouteKeyPath) -> Self {
        if let container = children.first(where: { $0.routeHash == route.hashValue }) {
            navigation.router.focus(to: container.screenView)
        }
        return self
    }
    
    @discardableResult
    public func focus<Output: Coordinable>(_ route: CoordinableTabRouteKeyPath<Output>) -> Output {
        guard let container = children.first(where: { $0.routeHash == route.hashValue }),
              let coordinator = container.coordinator else {
            fatalError("Route not registered.")
        }
        
        navigation.router.focus(to: container.screenView)
        return coordinator as! Output
    }
}
