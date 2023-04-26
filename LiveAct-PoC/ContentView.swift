//
//  ContentView.swift
//  LiveAct-PoC
//
//  Created by user214879 on 4/23/23.
//

//
//  ContentView.swift
//  AILiveActivity-push2
//
//  Created by user214879 on 4/19/23.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    @ObservedObject private var notificationHandler = NotificationHandler.shared
    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                startDeliveryPizza()
            }) {
                Text("Start Delivery")
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            
            Button(action: {
                stopDeliveryPizza()
            }) {
                Text("Stop Delivery")
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
        .onReceive(notificationHandler.$updatedStatus) { updatedStatus in
            if let updatedStatus = updatedStatus {
                updateActivity(with: updatedStatus)
            }
        }
    }
    
    private func updateActivity(with updatedStatus: PizzaDeliveryAttributes.PizzaDeliveryStatus) {
        Task {
            for activity in Activity<PizzaDeliveryAttributes>.activities {
                await activity.update(using: updatedStatus)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//import SwiftUI
//import ActivityKit
//
//
//struct ContentView: View {
//    var body: some View {
//        VStack(spacing: 20) {
//            Button(action: {
//                startDeliveryPizza()
//            }) {
//                Text("Start Delivery")
//                    .foregroundColor(.white)
//                    .frame(width: 200, height: 50)
//                    .background(Color.green)
//                    .cornerRadius(10)
//            }
//
//            Button(action: {
//                stopDeliveryPizza()
//            }) {
//                Text("Stop Delivery")
//                    .foregroundColor(.white)
//                    .frame(width: 200, height: 50)
//                    .background(Color.red)
//                    .cornerRadius(10)
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
