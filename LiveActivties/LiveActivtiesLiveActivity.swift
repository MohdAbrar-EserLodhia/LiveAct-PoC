//
//  LiveActivtiesLiveActivity.swift
//  LiveActivties
//
//  Created by user214879 on 4/23/23.
//


//
//  LiveWidgetsLiveActivity.swift
//  LiveWidgets
//
//  Created by user214879 on 4/19/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LiveWidgetsAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var value: Int
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct PizzaDeliveryActivityWidget: Widget {
    var body: some WidgetConfiguration {
        // attributesType changed to for - 16.1
        ActivityConfiguration(for: PizzaDeliveryAttributes.self) { context in
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(context.state.driverName) is on the way!").font(.headline)
                        HStack {
                            VStack {
                                Divider().frame(height: 6).overlay(.blue).cornerRadius(5)
                            }
                            Image(systemName: "box.truck.badge.clock.fill").foregroundColor(.blue)
                            VStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.secondary, style: StrokeStyle(lineWidth: 1, dash: [5]))
                                    .frame(height: 6)
                            }
                            Text(timerInterval: context.state.deliveryTimer, countsDown: true)
                            VStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.secondary, style: StrokeStyle(lineWidth: 1, dash: [5]))
                                    .frame(height: 6)
                            }
                            Image(systemName: "house.fill").foregroundColor(.green)
                        }
                    }.padding(.trailing, 25)
                    Text("\(context.attributes.numberOfPizzas) 🍕").font(.title).bold()
                }.padding(5)
                Text("You've already paid: \(context.attributes.totalAmount) + 50 delivery charges").font(.caption).foregroundColor(.secondary)
            }.padding(15)
        } dynamicIsland: { context in
            // Create the presentations that appear in the Dynamic Island.
            DynamicIsland {
                // Create the expanded presentation.
                DynamicIslandExpandedRegion(.leading) {
                    Label("\(context.attributes.numberOfPizzas) Pizzas", systemImage: "bag")
                        .foregroundColor(.indigo)
                        .font(.title2)
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    Label {
                        Text(timerInterval: context.state.deliveryTimer, countsDown: true)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 50)
                            .monospacedDigit()
                    } icon: {
                        Image(systemName: "timer")
                            .foregroundColor(.indigo)
                    }
                    .font(.title2)
                }
                
                DynamicIslandExpandedRegion(.center) {
                    Text("\(context.state.driverName) is on their way!")
                        .lineLimit(1)
                        .font(.caption)
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    Button {
                        // Deep link into your app.
                    } label: {
                        Label("Call driver", systemImage: "phone")
                    }
                    .foregroundColor(.indigo)
                }
            } compactLeading: {
                                    Label {
                                        Text("\(context.attributes.numberOfPizzas) Pizzas")
                                    } icon: {
                                        Image(systemName: "bag")
                                            .foregroundColor(.indigo)
                                    }
                                    .font(.caption2)
                                } compactTrailing: {
                                    Text(timerInterval: context.state.deliveryTimer, countsDown: true)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 40)
                                        .font(.caption2)
                                } minimal: {
                                    VStack(alignment: .center) {
                                        Image(systemName: "timer")
                                        Text(timerInterval: context.state.deliveryTimer, countsDown: true)
                                            .multilineTextAlignment(.center)
                                            .monospacedDigit()
                                            .font(.caption2)
                                    }
                                }
                                .keylineTint(.cyan)
                            }
                        }
                    }

struct LockScreenLiveActivityView: View {
    let context: ActivityViewContext<PizzaDeliveryAttributes>
    
    var body: some View {
        VStack {
            Spacer()
            Text("\(context.state.driverName) is on their way with your pizza!")
            Spacer()
            HStack {
                Spacer()
                Label {
                    Text("\(context.attributes.numberOfPizzas) Pizzas")
                } icon: {
                    Image(systemName: "bag")
                        .foregroundColor(.indigo)
                }
                .font(.title2)
                Spacer()
                Label {
                    Text(timerInterval: context.state.deliveryTimer, countsDown: true)
                        .multilineTextAlignment(.center)
                        .frame(width: 50)
                        .monospacedDigit()
                } icon: {
                    Image(systemName: "timer")
                        .foregroundColor(.indigo)
                }
                .font(.title2)
                Spacer()
            }
            Spacer()
        }
        .activitySystemActionForegroundColor(.indigo)
        .activityBackgroundTint(.cyan)
    }
}

//struct ActivityContent<State: Codable & Hashable>: Codable {
//    let state: State
//    let staleDate: Date?
//    let relevanceScore: Double?
//
//    init(state: State, staleDate: Date? = nil, relevanceScore: Double? = nil) {
//        self.state = state
//        self.staleDate = staleDate
//        self.relevanceScore = relevanceScore
//    }
//}
//
//func startPizzaDeliveryLiveActivity() {
//    if ActivityAuthorizationInfo().areActivitiesEnabled {
//        let minutes = 30
//        let seconds = 0
//        var future = Calendar.current.date(byAdding: .minute, value: minutes, to: Date())!
//        future = Calendar.current.date(byAdding: .second, value: seconds, to: future)!
//        let date = Date.now...future
//        let initialContentState = PizzaDeliveryAttributes.ContentState(driverName: "Bill James", deliveryTimer: date)
//        let activityAttributes = PizzaDeliveryAttributes(numberOfPizzas: 3, totalAmount: "$42.00", orderNumber: "12345")
//        let staleDate = Calendar.current.date(byAdding: .minute, value: 30, to: Date())!
//
//        let activityContent = ActivityContent(state: initialContentState, staleDate: staleDate)
//
//        do {
//            let deliveryActivity = try Activity.request(attributes: activityAttributes, contentState: activityContent)
//            print("Requested a pizza delivery Live Activity \(String(describing: deliveryActivity.id)).")
//        } catch (let error) {
//            print("Error requesting pizza delivery Live Activity \(error.localizedDescription).")
//        }
//    }
//}





