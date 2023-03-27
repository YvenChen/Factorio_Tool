//
//  factorioToolApp.swift
//  factorioTool
//
//  Created by Yven Chen on 2023/1/4.
//

import SwiftUI

@main
struct factorioToolApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            NotificationView()
                .environmentObject(modelData)
                .preferredColorScheme(.dark)
        }
    }
}
