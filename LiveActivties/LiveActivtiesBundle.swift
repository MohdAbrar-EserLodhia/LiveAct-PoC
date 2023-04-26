//
//  LiveActivtiesBundle.swift
//  LiveActivties
//
//  Created by user214879 on 4/23/23.
//


import WidgetKit
import SwiftUI

//@main
struct PizzaDeliveryWidgets: WidgetBundle {
    var body: some Widget {
        PizzaDeliveryActivityWidget()
        if #available(iOS 16.1, *) {
            PizzaDeliveryActivityWidget()
        }
    }
}
