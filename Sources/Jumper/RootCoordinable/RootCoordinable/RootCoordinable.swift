// Copyright (c) 2022 iDevs.io. All rights reserved.

import UIKit

public protocol RootCoordinable: Coordinable {
    
    // MARK: - Typealias
    typealias Route = RootRoute
    
    // MARK: - Properties
    var navigation: RootNavigation<Self> { get }
    
    // MARK: - Public methods
    func configure(controller: UIViewController)
}

extension RootCoordinable {
    public func configure(controller: UIViewController) {}
}

extension RootCoordinable {
    public var parent: ChildDismissable? {
        set { navigation.parent = newValue }
        get { navigation.parent }
    }
    
    public var children: [ChildContainer] {
        set { navigation.children = newValue }
        get { navigation.children }
    }
    
    private func setupRoot() -> ScreenView {
        if navigation.root == nil && navigation.router.rootController.children.isEmpty {
            let route = navigation.initial
            let routeContainer = self[keyPath: route] as! RouteScreenViewPresentable
            let input = navigation.initialInput
            let screen = routeContainer.screen(coordinator: self, input: input as Any)
            let childContainer = ChildContainer(
                coordinator: screen as? Coordinable,
                screenView: screen.view(),
                routeHash: route.hashValue,
                input: input
            )
            childContainer.coordinator?.parent = self
            navigation.root = childContainer
            navigation.router.setRoot(childContainer)
            configure(controller: navigation.router.rootController)
        }
        return navigation.router.rootController
    }
    
    internal func addChild(_ childContainer: ChildContainer) {
        childContainer.coordinator?.parent = self
        children.append(childContainer)
    }
}

extension RootCoordinable {
    public func view() -> ScreenView {
        setupRoot()
    }
}
