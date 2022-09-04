// Copyright (c) 2022 iDevs.io. All rights reserved.

import Foundation

extension Array where Element: Equatable {
    mutating func remove(element: Element) {
        if let index = firstIndex(of: element) {
            remove(at: index)
        }
    }
}
