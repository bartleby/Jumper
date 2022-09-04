// Copyright (c) 2022 iDevs.io. All rights reserved.

import Foundation

protocol RouteScreenViewPresentable {
    func screen(coordinator: Any, input: Any) -> ScreenViewPresentable
}

public struct RouteContainer<C: Coordinable, Input, Output: ScreenViewPresentable> {
    let screen: ((C) -> ((Input) -> Output))
}

extension RouteContainer: RouteScreenViewPresentable {
    func screen(coordinator: Any, input: Any) -> ScreenViewPresentable {
        if Input.self == Void.self {
            return screen(coordinator as! C)(() as! Input)
        } else {
            return screen(coordinator as! C)(input as! Input)
        }
    }
}
