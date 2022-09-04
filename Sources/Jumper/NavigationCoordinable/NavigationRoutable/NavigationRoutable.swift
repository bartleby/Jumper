// Copyright (c) 2022 iDevs.io. All rights reserved.

import UIKit

internal protocol NavigationRoutable: UIAdaptivePresentationControllerDelegate, UINavigationControllerDelegate {
    var navigationController: UINavigationController { get }
    var presentationControllerDidDismiss: ((ScreenView) -> Void)? { get set }
    var popViewControllerTo: ((ScreenView) -> Void)? { get set }
}
