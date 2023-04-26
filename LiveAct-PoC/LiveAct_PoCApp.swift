//
//  LiveAct_PoCApp.swift
//  LiveAct-PoC
//
//  Created by user214879 on 4/23/23.
//

import SwiftUI

@main
struct LiveAct_PoCApp: App {
    
    @UIApplicationDelegateAdaptor(NotificationApp.self) var appDelegate
    init() {
        NotificationManager.shared.requestAuthorization()
        NotificationManager.shared.registerForRemoteNotifications()
        
        Task {
            await observePushTokenUpdates()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
