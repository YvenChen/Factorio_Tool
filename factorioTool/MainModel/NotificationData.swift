//
//  NotificationData.swift
//  factorioTool
//
//  Created by Yven Chen on 2023/3/26.
//

import Foundation

final class NotificationData: ObservableObject {
    @Published var notification: Notification?
}

enum Notification: String, Error {
    case productNotExist = "产品不存在"
    case productExists = "产品已存在"
}
