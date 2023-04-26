//
//  NotificationManager.swift
//  LiveAct-PoC
//
//  Created by user214879 on 4/23/23.
//

import Foundation
import UserNotifications
import SwiftUI

class NotificationManager {
    static let shared = NotificationManager()

    init() {}
    private(set) var currentPushToken: String?

         public func updatePushToken(_ newToken: String) {
            print("Updating push token: \(newToken)")
            currentPushToken = newToken
            
        }
    
    func requestAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Request authorization for notifications failed: \(error)")
            }
        }
    }
    func registerForRemoteNotifications() {
        DispatchQueue.main.async {
            
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    func didRegisterForRemoteNotificationsWithDeviceToken(deviceToken: Data) {
        // Handle successful registration for remote notifications
        print("Device token: \(deviceToken)")
    }

    func didFailToRegisterForRemoteNotificationsWithError(error: Error) {
        // Handle failed registration for remote notifications
        print("Failed to register for remote notifications: \(error)")
    }
}
