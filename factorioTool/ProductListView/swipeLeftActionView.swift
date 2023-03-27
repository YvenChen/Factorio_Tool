//
//  SwipeLeftActionView.swift
//  factorioTool
//
//  Created by Yven Chen on 2023/3/25.
//

import SwiftUI

struct SwipeLeftAction: ViewModifier {
    var action: () -> Void
    
    @GestureState private var dragOffsetState: CGFloat = .zero
    @State private var contentOffset: CGFloat = .zero
    
    var contentOffsetState: CGFloat {
        min(0, contentOffset + dragOffsetState)
    }
    
    var drag: some Gesture {
        DragGesture(coordinateSpace: .local)
            .updating($dragOffsetState) { value, state, transaction in
                state = value.translation.width
            }
            .onEnded { value in
                if value.translation.width > -40 {
                    contentOffset = .zero
                } else {
                    contentOffset = -80
                }
            }
    }
    
    var tap: some Gesture {
        TapGesture()
            .onEnded {
                contentOffset = .zero
            }
    }
    
    func body(content: Content) -> some View {
        content
            .disabled(!(contentOffsetState == .zero))
            .offset(x: contentOffsetState)
            .simultaneousGesture(drag.exclusively(before: tap))
            .background {
                if !(contentOffsetState == .zero) {
                    HStack {
                        Spacer()
                        VStack {
                            Spacer()
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.red)
                                .font(.title2)
                                .scaleEffect(min(1, (contentOffsetState - 20) * -0.01))
                            Spacer()
                        }
                        .frame(width: 96)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation { action() }
                        }
                    }
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .animation(.linear, value: contentOffsetState)
    }
}
