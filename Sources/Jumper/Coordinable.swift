// Copyright (c) 2022 iDevs.io. All rights reserved.

import UIKit

public protocol ChildDismissable {
    func dismissChild<T: Coordinable>(coordinator: T, action: (() -> Void)?)
}

public protocol Coordinable: AnyObject, ScreenViewPresentable, ChildDismissable {
    
    // MARK: - Typealias
    typealias ScreenRouteKeyPath = KeyPath<Self, RouteContainer<Self, Void, ScreenView>>
    typealias CoordinableRouteKeyPath<Output: Coordinable> = KeyPath<Self, RouteContainer<Self, Void, Output>>
    typealias InputScreenRouteKeyPath<Input> = KeyPath<Self, RouteContainer<Self, Input, ScreenView>>
    typealias InputCoordinableRouteKeyPath<Input, Output: Coordinable> = KeyPath<Self, RouteContainer<Self, Input, Output>>
    
    var parent: ChildDismissable? { get set }
    var children: [ChildContainer] { get set }
    func dismiss(_ action: (() -> Void)?)
}
