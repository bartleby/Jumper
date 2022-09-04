// Copyright (c) 2022 iDevs.io. All rights reserved.

import UIKit

public protocol NavigationCoordinable: Coordinable {
    
    // MARK: - Typealias
    typealias Route = NavigationRoute
    
    // MARK: - Properties
    var navigation: Navigation<Self> { get }

    // MARK: - Public methods
    func configure(controller: UINavigationController)
}

extension NavigationCoordinable {
    public func configure(controller: UINavigationController) {}
}

extension NavigationCoordinable {
    public var children: [ChildContainer] {
        get { navigation.children }
        set { navigation.children = newValue }
    }
    
    public var parent: ChildDismissable? {
        get { navigation.parent }
        set { navigation.parent = newValue }
    }
    
    private func setupRoot() -> ScreenView {
        if navigation.router.navigationController.viewControllers.isEmpty {
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
            addChild(childContainer)
            navigation.router.setRoot(childContainer, animated: false)
            configure(controller: navigation.router.navigationController)
        }
        return navigation.router.navigationController
    }
    
    internal func addChild(_ childContainer: ChildContainer) {
        childContainer.coordinator?.parent = self
        children.append(childContainer)
    }
}

extension NavigationCoordinable {
    public func view() -> ScreenView {
        setupRoot()
    }
}
