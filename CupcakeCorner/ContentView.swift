//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Mete Alp Kizilcay on 27.10.2020.
//

import SwiftUI

//class User: ObservableObject, Codable {
//    enum CodingKeys: CodingKey {
//        case name
//    }
//    @Published var name = "Paul Hudson"
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//    }
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(name, forKey: .name)
//    }
//}

struct ContentView: View {
    @ObservedObject var order = Order()
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type){
                        ForEach(0..<Order.types.count){
                            Text(Order.types[$0])
                        }
                    }
                }
                
                Stepper(value: $order.quantity, in: 3...20) {
                    Text("Number of cakes:\(order.quantity)")
                }
                Section {
                    Toggle(isOn: $order.specialRequestEnabled.animation(), label: {
                        Text("Any special requests?")
                    })
                    if order.specialRequestEnabled {
                        Toggle(isOn: $order.extraFrosting, label: {
                            Text("Extra frosting")
                        })
                        Toggle(isOn: $order.addSprinkles, label: {
                            Text("Add Sprinkles")
                        })
                    }
                }
                
                Section {
                    NavigationLink (
                        destination: AddressView(order: order),
                        label: {
                            Text("Delivery Details")
                        })
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
