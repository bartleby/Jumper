// Copyright (c) 2022 iDevs.io. All rights reserved.

import Foundation

protocol TabRouteScreenViewPresentable {
    func screen(coordinator: Any) -> ScreenViewPresentable
    func tabItem(coordinator: Any) -> TabBarItem
}

public struct TabRouteContainer<C: TabCoordinable, Output: ScreenViewPresentable> {
    let screen: ((C) -> (() -> Output))
    let tabItem: ((C) -> (() -> TabBarItem))
}

extension TabRouteContainer: TabRouteScreenViewPresentable {
    func screen(coordinator: Any) -> ScreenViewPresentable {
        screen(coordinator as! C)()
    }
    
    func tabItem(coordinator: Any) -> TabBarItem {
        tabItem(coordinator as! C)()
    }
}
