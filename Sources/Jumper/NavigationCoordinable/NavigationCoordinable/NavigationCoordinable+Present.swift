// Copyright (c) 2022 iDevs.io. All rights reserved.

import Foundation

extension NavigationCoordinable {
    @discardableResult
    public func present<Output: Coordinable>(
        _ route: CoordinableRouteKeyPath<Output>,
        animated: Bool = true
    ) -> Output {
        let routeContainer = self[keyPath: route]
        let screen = routeContainer.screen(self)(())
        let childContainer = ChildContainer(
            coordinator: screen,
            screenView: screen.view(),
            routeHash: route.hashValue
        )
        addChild(childContainer)
        navigation.router.present(childContainer, animated: animated)
        return screen
    }
    
    @discardableResult
    public func present<Input, Output: Coordinable>(
        _ route: InputCoordinableRouteKeyPath<Input, Output>,
        input: Input,
        animated: Bool = true
    ) -> Output {
        let routeContainer = self[keyPath: route]
        let screen = routeContainer.screen(self)(input)
        let childContainer = ChildContainer(
            coordinator: screen,
            screenView: screen.view(),
            routeHash: route.hashValue,
            input: input
        )
        addChild(childContainer)
        navigation.router.present(childContainer, animated: animated)
        return screen
    }
}

extension NavigationCoordinable {
    @discardableResult
    public func present(_ route: ScreenRouteKeyPath, animated: Bool = true) -> Self {
        let routeContainer = self[keyPath: route]
        let screen = routeContainer.screen(self)(())
        let childContainer = ChildContainer(
            screenView: screen.view(),
            routeHash: route.hashValue
        )
        addChild(childContainer)
        navigation.router.present(childContainer, animated: animated)
        return self
    }
    
    @discardableResult
    public func present<Input>(_ route: InputScreenRouteKeyPath<Input>, input: Input, animated: Bool = true) -> Self {
        let routeContainer = self[keyPath: route]
        let screen = routeContainer.screen(self)(input)
        let childContainer = ChildContainer(
            screenView: screen.view(),
            routeHash: route.hashValue,
            input: input
        )
        addChild(childContainer)
        navigation.router.present(childContainer, animated: animated)
        return self
    }
}
