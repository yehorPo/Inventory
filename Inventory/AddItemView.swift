//
//  AddItemView.swift
//  Inventory
//
//  Created by Yehor Podolskyi on 26.05.2023.
//

import SwiftUI

struct AddItemView: View {
    
    @Binding var item:Item
//    @ObservedObject var stateManager:StateManager
    
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Name", text: $item.name)
                    Stepper("Level: \(item.level)", value: $item.level)
                    Picker("Item type", selection: $item.type) {
                        Text("None")
                            .tag(Optional<String>(nil))
                        ForEach(Item.ItemType.allCases, id: \.self) { type in
                            Text(type.rawValue.capitalized)
                                .tag(Optional(type))
                        }
                    }
                }
                Section("Enchantment") {
                    switch item.enchantment{
                    case let .isEnchanted(level: level):
                        Stepper("Level: \(level)", value: $item.enchantment.level)
                        Button("Disenchant") {
                            item.enchantment = .common
                        }
                    case .common:
                        Button("Enchant") {
                            item.enchantment = .isEnchanted(level: 1)
                        }
                    }
                }
            }
        }
    }
}
//struct Wrapper:View{
//    
//    @State var item = Item(name: "Sword", level: 1, enchantment: .common, type: .misc)
//    
//    
//    var body: some View{
//        NavigationView {
//            AddItemView(item: $item)
//                    .navigationTitle("Add new item")
//        }
//    }
//}
//
//struct AddItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        Wrapper()
//    }
//}
