// Copyright (c) 2022 iDevs.io. All rights reserved.

import UIKit

extension NavigationCoordinable {
    @discardableResult
    public func root<Output: Coordinable>(
        _ route: CoordinableRouteKeyPath<Output>,
        animated: Bool = true
    ) -> Output {
        let routeContainer = self[keyPath: route]
        let screen = routeContainer.screen(self)(())
        let childContainer = ChildContainer(
            coordinator: screen,
            screenView: screen.view(),
            routeHash: route.hashValue,
            input: nil
        )
        addChild(childContainer)
        navigation.router.setRoot(childContainer, animated: animated)
        return screen
    }
    
    @discardableResult
    public func root<Input, Output: Coordinable>(
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
            input: nil
        )
        addChild(childContainer)
        navigation.router.setRoot(childContainer, animated: animated)
        return screen
    }
}

extension NavigationCoordinable {
    @discardableResult
    public func root(_ route: ScreenRouteKeyPath, animated: Bool = true) -> Self {
        let routeContainer = self[keyPath: route]
        let screen = routeContainer.screen(self)(())
        let childContainer = ChildContainer(
            screenView: screen.view(),
            routeHash: route.hashValue
        )
        addChild(childContainer)
        navigation.router.setRoot(childContainer, animated: animated)
        return self
    }
    
    @discardableResult
    public func root<Input>(_ route: InputScreenRouteKeyPath<Input>, input: Input, animated: Bool) -> Self {
        let routeContainer = self[keyPath: route]
        let screen = routeContainer.screen(self)(input)
        let childContainer = ChildContainer(
            screenView: screen.view(),
            routeHash: route.hashValue,
            input: input
        )
        addChild(childContainer)
        navigation.router.setRoot(childContainer, animated: animated)
        return self
    }
}
