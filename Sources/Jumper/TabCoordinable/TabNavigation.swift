// Copyright (c) 2022 iDevs.io. All rights reserved.

import Foundation

public class TabNavigation<T: TabCoordinable> {
    public typealias TabKeyPath = PartialKeyPath<T>
    internal var parent: ChildDismissable?
    internal var children: [ChildContainer] = []
    var router: TabRouter = TabRouter()
    internal let initial: [TabKeyPath]
    
    public init(@TabBuilder<TabKeyPath> initial: () -> [TabKeyPath]) {
        self.initial = initial()
        setupRouter()
    }
    
    internal func setupRouter() {
        router.presentationControllerDidDismiss = { [unowned self] screen in
            if let index = self.children.firstIndex(where: { $0.screenView === screen }) {
                self.children.remove(at: index)
            }
        }
    }
}

@resultBuilder
public struct TabBuilder<T> {
    public static func buildBlock(_ components: T...) -> [T] {
        components
    }
}
