// Copyright (c) 2022 iDevs.io. All rights reserved.

import Foundation

public class RootNavigation<T: RootCoordinable> {
    internal var parent: ChildDismissable?
    internal var children: [ChildContainer] = []
    internal var router: RootRouter = RootRouter()
    internal let initial: PartialKeyPath<T>
    internal let initialInput: Any?
    internal var root: ChildContainer?
    
    public init(initial: PartialKeyPath<T>, _ initialInput: Any? = nil) {
        self.initial = initial
        self.initialInput = initialInput
        setupRouter()
    }
    
    internal func setupRouter() {
        router.presentationControllerDidDismiss = { [unowned self] screen in
            if let index = children.firstIndex(where: { $0.screenView === screen }) {
                children.remove(at: index)
            }
        }
    }
}
