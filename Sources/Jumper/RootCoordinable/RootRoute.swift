// Copyright (c) 2022 iDevs.io. All rights reserved.

import Foundation

@propertyWrapper
public class RootRoute<C: Coordinable, Input, Output: ScreenViewPresentable> {
    public var wrappedValue: RouteContainer<C, Input, Output>
    private init(route: RouteContainer<C, Input, Output>) {
        self.wrappedValue = route
    }
}

extension RootRoute where C: Coordinable, Output: ScreenViewPresentable {
    public convenience init(wrappedValue: @escaping ((C) -> ((Input) -> Output))) {
        self.init(route: RouteContainer(screen: { coordinator in
            return { input in wrappedValue(coordinator)(input) }
        }))
    }
}

extension RootRoute where C: Coordinable, Input == Void , Output: ScreenViewPresentable {
    public convenience init(wrappedValue: @escaping ((C) -> (() -> Output))) {
        self.init(route: RouteContainer(screen: { coordinator in
            return { _ in wrappedValue(coordinator)() }
        }))
    }
}
