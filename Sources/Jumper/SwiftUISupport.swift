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
    private let presenter: UIKitPresenter?
    
    public init(
        content: Content,
        modalPresentationStyle: UIModalPresentationStyle = .automatic,
        presenter: UIKitPresenter? = nil
    ) {
        self.content = content
        self.modalPresentationStyle = modalPresentationStyle
        self.presenter = presenter
    }
    
    public func view() -> ScreenView {
        let hostingController = UIHostingController(rootView: 
            content.environment(\.uiKitPresenter, presenter)
        )
        hostingController.modalPresentationStyle = modalPresentationStyle
        return hostingController
    }
}

// Модификаторы для SwiftUI
extension View {
    public func modalPresentationStyle(_ style: UIModalPresentationStyle) -> some View {
        environment(\.modalPresentationStyle, style)
    }
    
    public func presentUIKit<Content: View>(
        style: UIModalPresentationStyle = .automatic,
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.background(
            UIKitPresenterView(
                isPresented: isPresented,
                style: style,
                content: content
            )
        )
    }
}

private struct UIKitPresenterView<Content: View>: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    let style: UIModalPresentationStyle
    let content: () -> Content
    
    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if isPresented {
            let hostingController = UIHostingController(rootView: content())
            hostingController.modalPresentationStyle = style
            uiViewController.present(hostingController, animated: true)
        } else {
            uiViewController.dismiss(animated: true)
        }
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