// Copyright (c) 2022 iDevs.io. All rights reserved.

import Foundation

@propertyWrapper
public class TabRoute<C: TabCoordinable, Output: ScreenViewPresentable> {
    public var wrappedValue: TabRouteContainer<C, Output>
    
    private init(route: TabRouteContainer<C, Output>) {
        self.wrappedValue = route
    }
}

extension TabRoute where C: Coordinable, Output: ScreenViewPresentable {
    public convenience init(
        wrappedValue: @escaping ((C) -> (() -> Output)),
        tabItem: @escaping ((C) -> (() -> TabBarItem))
    ) {
        self.init(route: TabRouteContainer(
            screen: { coordinator in return { wrappedValue(coordinator)() }},
            tabItem: tabItem
        ))
    }
}
