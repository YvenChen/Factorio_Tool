//
//  swipeLeftActionView.swift
//  factorioTool
//
//  Created by Yven Chen on 2023/3/25.
//

import SwiftUI

struct swipeLeftActionView: View {
    var action: () -> Void
    
    var body: some View {
        Button(role: .destructive) {
            withAnimation { action() }
        } label: {
            Image(systemName: "xmark.circle.fill")
        }
    }
}
