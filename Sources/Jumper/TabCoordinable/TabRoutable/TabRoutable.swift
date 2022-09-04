// Copyright (c) 2022 iDevs.io. All rights reserved.

import UIKit

internal protocol TabRoutable: UIAdaptivePresentationControllerDelegate {
    var tabController: UITabBarController { get }
    var presentationControllerDidDismiss: ((ScreenView) -> Void)? { get set }
}
