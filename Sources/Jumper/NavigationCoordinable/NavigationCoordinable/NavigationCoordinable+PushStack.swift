// Copyright (c) 2022 iDevs.io. All rights reserved.

import Foundation

extension NavigationCoordinable {
    @discardableResult
    public func push(@RouteStackBuilder<ScreenRouteKeyPath> stack: () -> [ScreenRouteKeyPath]) -> Self {
        let stack = stack()
        for (index, route) in stack.enumerated() {
            if index == stack.count - 1 {
                self.push(route, animated: true)
            } else {
                self.push(route, animated: false)
            }
        }
        return self
    }
}

@resultBuilder
public struct RouteStackBuilder<T> {
    public static func buildBlock(_ components: T...) -> [T] {
        components
    }
}
