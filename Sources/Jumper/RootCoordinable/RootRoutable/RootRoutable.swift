// Copyright (c) 2022 iDevs.io. All rights reserved.

import UIKit

internal protocol RootRoutable: UIAdaptivePresentationControllerDelegate {
    var rootController: ScreenView { get }
    var presentationControllerDidDismiss: ((ScreenView) -> Void)? { get set }
}
