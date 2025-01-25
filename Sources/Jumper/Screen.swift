// Copyright (c) 2024 iDevs.io. All rights reserved.

import UIKit
import SwiftUI

public struct Screen<ViewModel>: ScreenViewPresentable {
    private let screenView: ScreenViewPresentable
    public let viewModel: ViewModel
    
    public init(screenView: ScreenViewPresentable, viewModel: ViewModel) {
        self.screenView = screenView
        self.viewModel = viewModel
    }
    
    public func view() -> ScreenView {
        screenView.view()
    }
    
    public func configure(_ configure: (ViewModel) -> Void) -> Self {
        configure(viewModel)
        return self
    }
}

extension Screen where ViewModel == Void {
    public init(screenView: ScreenViewPresentable) {
        self.init(screenView: screenView, viewModel: ())
    }
} 