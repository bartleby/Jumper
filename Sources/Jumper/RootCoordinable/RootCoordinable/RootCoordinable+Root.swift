// Copyright (c) 2022 iDevs.io. All rights reserved.

import Foundation

extension RootCoordinable {
    @discardableResult
    public func root<Output: Coordinable>(
        _ route: CoordinableRouteKeyPath<Output>
    ) -> Output {
        let routeContainer = self[keyPath: route]
        let screen = routeContainer.screen(self)(())
        let childContainer = ChildContainer(
            coordinator: screen,
            screenView: screen.view(),
            routeHash: route.hashValue,
            input: nil
        )
        childContainer.coordinator?.parent = self
        navigation.root = childContainer
        navigation.router.setRoot(childContainer)
        return screen
    }
    
    @discardableResult
    public func root<Input, Output: Coordinable>(
        _ route: InputCoordinableRouteKeyPath<Input, Output>,
        input: Input
    ) -> Output {
        let routeContainer = self[keyPath: route]
        let screen = routeContainer.screen(self)(input)
        let childContainer = ChildContainer(
            coordinator: screen,
            screenView: screen.view(),
            routeHash: route.hashValue,
            input: input
        )
        childContainer.coordinator?.parent = self
        navigation.root = childContainer
        navigation.router.setRoot(childContainer)
        return screen
    }
}

extension RootCoordinable {
    @discardableResult
    public func root(_ route: ScreenRouteKeyPath) -> Self {
        let routeContainer = self[keyPath: route]
        let screen = routeContainer.screen(self)(())
        let childContainer = ChildContainer(
            screenView: screen.view(),
            routeHash: route.hashValue
        )
        childContainer.coordinator?.parent = self
        navigation.root = childContainer
        navigation.router.setRoot(childContainer)
        return self
    }
    
    @discardableResult
    public func root<Input>(
        _ route: InputScreenRouteKeyPath<Input>,
        input: Input
    ) -> Self {
        let routeContainer = self[keyPath: route]
        let screen = routeContainer.screen(self)(input)
        let childContainer = ChildContainer(
            screenView: screen.view(),
            routeHash: route.hashValue,
            input: input
        )
        childContainer.coordinator?.parent = self
        navigation.root = childContainer
        navigation.router.setRoot(childContainer)
        return self
    }
}

extension RootCoordinable {
    public func isRoot<Output: Coordinable>(_ route: CoordinableRouteKeyPath<Output>) -> Bool {
        navigation.root?.routeHash == route.hashValue
    }
    
    public func isRoot(_ route: ScreenRouteKeyPath) -> Bool {
        navigation.root?.routeHash == route.hashValue
    }
    
    public func hasRoot<Output: Coordinable>(_ route: CoordinableRouteKeyPath<Output>) -> Output? {
        if navigation.root?.routeHash == route.hashValue {
            return navigation.root?.coordinator as? Output
        }
        return nil
    }
}
