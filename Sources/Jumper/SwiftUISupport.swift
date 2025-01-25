// Copyright (c) 2024 iDevs.io. All rights reserved.

import UIKit
import SwiftUI

public protocol SwiftUIScreenPresentable {
    associatedtype Content: View
    func makeSwiftUIView() -> Content
}

public struct SwiftUIScreen<Content: View>: ScreenViewPresentable {
    private let content: Content
    private let modalPresentationStyle: UIModalPresentationStyle
    
    public init(
        content: Content,
        modalPresentationStyle: UIModalPresentationStyle = .automatic
    ) {
        self.content = content
        self.modalPresentationStyle = modalPresentationStyle
    }
    
    public func view() -> ScreenView {
        let hostingController = UIHostingController(rootView: content)
        hostingController.modalPresentationStyle = modalPresentationStyle
        return hostingController
    }
}

extension View {
    public func modalPresentationStyle(_ style: UIModalPresentationStyle) -> some View {
        environment(\.modalPresentationStyle, style)
    }
}

private struct ModalPresentationStyleKey: EnvironmentKey {
    static let defaultValue: UIModalPresentationStyle = .automatic
}

extension EnvironmentValues {
    var modalPresentationStyle: UIModalPresentationStyle {
        get { self[ModalPresentationStyleKey.self] }
        set { self[ModalPresentationStyleKey.self] = newValue }
    }
} 