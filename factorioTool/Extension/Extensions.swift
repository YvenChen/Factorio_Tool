//
//  Extensions.swift
//  factorioTool
//
//  Created by Yven Chen on 2023/1/4.
//

import SwiftUI

extension PresentationDetent {
    static let myDetent = Self.custom(MyDetent.self)
}

struct MyDetent: CustomPresentationDetent {
    static func height(in context: Context) -> CGFloat? {
        return context.maxDetentValue * 0.1
    }
}

extension View {
    func swipeLeftAction(action: @escaping () -> Void) -> some View {
        modifier(SwipeLeftAction(action: action))
    }
}
