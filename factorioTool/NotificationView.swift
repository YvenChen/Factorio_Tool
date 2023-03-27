//
//  NotificationView.swift
//  factorioTool
//
//  Created by Yven Chen on 2023/3/26.
//

import SwiftUI
import AlertToast

struct NotificationView: View {
    @StateObject private var notificationData = NotificationData()
    
    @State private var isErrorPresented: Bool = false
    @State private var notification: Notification?
    
    var body: some View {
        ContentView()
            .environmentObject(notificationData)
            .toast(isPresenting: $isErrorPresented) {
                AlertToast(displayMode: .hud, type: .error(.red), title: notification?.rawValue)
            }
            .onChange(of: notificationData.notification) { value in
                guard let value else { return }
                notification = notificationData.notification
                switch value {
                case Notification.productNotExist, Notification.productExists:
                    isErrorPresented.toggle()
                }
                notificationData.notification = nil
            }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
