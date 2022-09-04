// Copyright (c) 2022 iDevs.io. All rights reserved.

import Foundation

public struct ChildContainer {
    let id: UUID = UUID()
    let coordinator: Coordinable?
    var screenView: ScreenView
    let routeHash: Int
    let input: Any?
    
    public init(
        coordinator: Coordinable? = nil,
        screenView: ScreenView,
        routeHash: Int,
        input: Any? = nil
    ) {
        self.coordinator = coordinator
        self.screenView = screenView
        self.routeHash = routeHash
        self.input = input
    } 
}

extension ChildContainer: ScreenViewPresentable {
    public func view() -> ScreenView {
        self.screenView
    }
}

extension ChildContainer: Equatable {
    public static func == (lhs: ChildContainer, rhs: ChildContainer) -> Bool {
        lhs.id == rhs.id
    }
}
