//
//  Functions.swift
//  LiveAct-PoC
//
//  Created by user214879 on 4/23/23.
//

//
//  Functions.swift
//  AILiveActivity-push2
//
//  Created by user214879 on 4/19/23.
//

import Foundation
import ActivityKit
import UserNotifications
import SwiftUI


//func sendPushTokenToServer(pushToken: Data) {
//    let url = URL(string: "https://yourserver.com/api/endpoint")! // Replace with your server's API endpoint
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//    let tokenString = pushToken.map { String(format: "%02x", $0) }.joined()
//    let json: [String: Any] = ["pushToken": tokenString]
//
//    do {
//        let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
//        request.httpBody = jsonData
//    } catch {
//        print("Error encoding JSON: \(error)")
//        return
//    }
//
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//        if let error = error {
//            print("Error sending push token to server: \(error)")
//            return
//        }
//
//        if let response = response as? HTTPURLResponse, response.statusCode != 200 {
//            print("Unexpected status code from server: \(response.statusCode)")
//            return
//        }
//
//        print("Successfully sent push token to server")
//    }
//    task.resume()
//}
//
//func startDeliveryPizza() {
//    let pizzaDeliveryAttributes = PizzaDeliveryAttributes(numberOfPizzas: 1, totalAmount: 450, orderNumber: "#324")
//        let startDate = Date()
//        let endDate = startDate.addingTimeInterval(15 * 60)
//        let deliveryTimer = startDate...endDate
//        let content = PizzaDeliveryAttributes.PizzaDeliveryStatus(driverName: "Ra.One", deliveryTimer: deliveryTimer)
//
//
//    do {
//                let activity = try Activity<PizzaDeliveryAttributes>.request(
//                    attributes: pizzaDeliveryAttributes,
//                    contentState: initialContentState,
//                    pushType: .token
//                )
//
//                print("Requested a pizza activity with id: \(activity.id)")
//            } catch {
//                print("Error: \(error)")
//            }
//}




//func startDeliveryPizza() {
//    let pizzaDeliveryAttributes = PizzaDeliveryAttributes(numberOfPizzas: 1, totalAmount: 450, orderNumber: "#324")
//    let initialContentState = PizzaDeliveryAttributes.PizzaDeliveryStatus(driverName: "Ra.One", deliveryTimer: Date()...Date().addingTimeInterval(15 * 60))
//
//    Task {
//        do {
//            for activity in try Activity<PizzaDeliveryAttributes>.activities {
//                if let data = activity.pushToken {
//                    let mytoken = data.map { String(format: "%02x", $0) }.joined()
//                    print("act push token", mytoken)
//                }
//            }
//        } catch let error {
//            print("Error requesting pizza delivery Live Activity \(error.localizedDescription)")
//        }
//    }
//}

func startDeliveryPizza() {
    let pizzaDeliveryAttributes = PizzaDeliveryAttributes(numberOfPizzas: 1, totalAmount: 450, orderNumber: "#324")
    
    let startDate = Date()
    let endDate = startDate.addingTimeInterval(15 * 60)
    let deliveryTimer = startDate...endDate
    let initialContentState = PizzaDeliveryAttributes.PizzaDeliveryStatus(driverName: "Ra.One", deliveryTimer: deliveryTimer)
    
    do {
        let activity = try Activity<PizzaDeliveryAttributes>.request(
            attributes: pizzaDeliveryAttributes,
            contentState: initialContentState,
            pushType: .token
        )

        print("pushToken: \(activity.pushToken)")
    } catch {
        print("Error: \(error)")
    }
}

//    do {
//        let deliveryActivity = try Activity<PizzaDeliveryAttributes>.request(
//            attributes: pizzaDeliveryAttributes,
//            contentState: initialContentState,
//            pushType: nil)
//        print("Requested a pizza delivery Live Activity \(deliveryActivity.id)")
//
//        // Get the push token
//        do {
//            let deliveryActivity = try Activity<PizzaDeliveryAttributes>.request(
//                attributes: pizzaDeliveryAttributes,
//                contentState: initialContentState,
//                pushType: nil)
//            print("Requested a pizza delivery Live Activity \(deliveryActivity.id)")
//        } catch (let error) {
//            print("Error requesting pizza delivery Live Activity \(error.localizedDescription)")
//        }
//    }
//}
//


func updateDeliveryPizza() {
    Task {
        // Date() changed to Date()...Date() - 16.1
        let updatedDeliveryStatus = PizzaDeliveryAttributes.PizzaDeliveryStatus(driverName: "Ra.One", deliveryTimer: Date()...Date().addingTimeInterval(60 * 60))
        
        for activity in Activity<PizzaDeliveryAttributes>.activities{
            await activity.update(using: updatedDeliveryStatus)
        }
    }
}

func stopDeliveryPizza() {
    Task {
        for activity in Activity<PizzaDeliveryAttributes>.activities{
            await activity.end(dismissalPolicy: .immediate)
        }
    }
}

func showAllDeliveries() {
    Task {
        for activity in Activity<PizzaDeliveryAttributes>.activities {
            print("Pizza delivery details: \(activity.id) -> \(activity.attributes)")
        }
    }
}

func processUpdatedPushToken(_ pushTokenUpdate: String) {
    print("Processing updated push token: \(pushTokenUpdate)")
    
    // Update the push token using the NotificationManager
//    NotificationManager.shared.updatePushToken(pushTokenUpdate)
    NotificationManager.shared.updatePushToken(pushTokenUpdate)
   // NotificationManager.updatePushToken(pushTokenUpdate)
    
}

func observePushTokenUpdates() async {
    Task {
        for activity in Activity<PizzaDeliveryAttributes>.activities {
            for await pushTokenUpdate in activity.pushTokenUpdates {
                print("Push token update: \(pushTokenUpdate)")
                // Handle the push token update here
            }
        }
    }
}


