// Copyright (c) 2022 iDevs.io. All rights reserved.

import UIKit

public protocol TabCoordinable: Coordinable {
    
    // MARK: - Typealias
    typealias Route = TabRoute
    typealias TabRouteKeyPath = KeyPath<Self, TabRouteContainer<Self, ScreenView>>
    typealias CoordinableTabRouteKeyPath<Output: Coordinable> = KeyPath<Self, TabRouteContainer<Self, Output>>
    
    // MARK: - Properties
    var navigation: TabNavigation<Self> { get }
    
    // MARK: - Public methods
    func configure(controller: UITabBarController)
}

extension TabCoordinable {
    public func configure(controller: UITabBarController) {}
}

extension TabCoordinable {
    public var children: [ChildContainer] {
        get { navigation.children }
        set { navigation.children = newValue }
    }
    
    public var parent: ChildDismissable? {
        get { navigation.parent }
        set { navigation.parent = newValue }
    }
    
    private func setupRoot() -> ScreenView {
        if navigation.router.tabController.viewControllers == nil {
            let containers: [ChildContainer] = navigation.initial.map { route in
                let routeContainer = self[keyPath: route] as! TabRouteScreenViewPresentable
                let screen = routeContainer.screen(coordinator: self)
                let tabItem = routeContainer.tabItem(coordinator: self)
                let view = screen.view()
                let childContainer = ChildContainer(
                    coordinator: screen as? Coordinable,
                    screenView: view,
                    routeHash: route.hashValue
                )
                view.tabBarItem = tabItem
                return childContainer
            }
            children = containers
            navigation.router.tabController.viewControllers = containers.map(\.screenView)
            configure(controller: navigation.router.tabController)
        }
        return navigation.router.tabController
    }
    
    internal func addChild(_ childContainer: ChildContainer) {
        childContainer.coordinator?.parent = self
        children.append(childContainer)
    }
}

extension TabCoordinable {
    public func view() -> ScreenView {
        setupRoot()
    }
}
