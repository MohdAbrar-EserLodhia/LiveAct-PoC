//
//  PizzaDeliveryAttributes.swift
//  LiveAct-PoC
//
//  Created by user214879 on 4/23/23.
//

import Foundation
import ActivityKit

struct PizzaDeliveryAttributes: ActivityAttributes {
    public typealias PizzaDeliveryStatus = ContentState

    public struct ContentState: Codable, Hashable {
        var driverName: String
        var deliveryTimer: ClosedRange<Date>
    }

    var numberOfPizzas: Int
    var totalAmount: Int
    var orderNumber: String
}
