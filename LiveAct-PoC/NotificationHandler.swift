//
//  NotificationHandler.swift
//  LiveAct-PoC
//
//  Created by user214879 on 4/23/23.
//

import SwiftUI
import Combine

class NotificationHandler: ObservableObject {
    @Published var updatedStatus: PizzaDeliveryAttributes.PizzaDeliveryStatus?

    static let shared = NotificationHandler()

    private init() {}
}
