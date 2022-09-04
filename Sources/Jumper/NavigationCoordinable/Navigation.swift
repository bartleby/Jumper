// Copyright (c) 2022 iDevs.io. All rights reserved.

import Foundation

public class Navigation<T: NavigationCoordinable> {
    internal var parent: ChildDismissable?
    internal var children: [ChildContainer] = []
    internal var router: NavigationRoutable = NavigationRouter()
    internal let initial: PartialKeyPath<T>
    internal let initialInput: Any?
    
    public init(initial: PartialKeyPath<T>, _ initialInput: Any? = nil) {
        self.initial = initial
        self.initialInput = initialInput
        setupRouter()
    }
    
    private func setupRouter() {
        router.presentationControllerDidDismiss = { [unowned self] screen in
            if let index = self.children.firstIndex(where: { $0.screenView === screen }) {
                self.children.remove(at: index)
            }
        }
        
        router.popViewControllerTo = { [unowned self] screen in
            if let index = children.firstIndex(where: { $0.screenView === screen }) {
                children.suffix(from: index + 1).forEach { item in
                    children.remove(element: item)
                }
            }
        }
    }
}
