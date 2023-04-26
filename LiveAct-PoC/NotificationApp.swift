//
//  NotificationApp.swift
//  LiveAct-PoC
//
//  Created by user214879 on 4/23/23.
//

//
//  NotificationApp.swift
//  AILiveActivity-push2
//
//  Created by user214879 on 4/19/23.
//


import Foundation
import SwiftUI

class NotificationApp: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        NotificationManager.shared.didRegisterForRemoteNotificationsWithDeviceToken(deviceToken: deviceToken)
        print("Device token: \(deviceToken)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //            if let aps = userInfo["aps"] as? [String: AnyObject], let contentState = aps["content-state"] as? [String: Any] {
        if let aps = userInfo["aps"] as? [String: AnyObject], let alert = aps["alert"] as? [String: AnyObject], let contentState = alert["content-state"] as? [String: Any] {
            let driverName = contentState["driverName"] as? String ?? ""
            let deliveryTimer = contentState["deliveryTimer"] as? TimeInterval ?? 0
            let deliveryTimerRange = Date()...Date().addingTimeInterval(deliveryTimer)
            
            let updatedStatus = PizzaDeliveryAttributes.PizzaDeliveryStatus(driverName: driverName, deliveryTimer: deliveryTimerRange)
            NotificationHandler.shared.updatedStatus = updatedStatus
            
            completionHandler(.newData)
        } else {
            completionHandler(.noData)
        }
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        NotificationManager.shared.didFailToRegisterForRemoteNotificationsWithError(error: error)
    }
}
