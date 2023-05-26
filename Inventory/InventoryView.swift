//
//  InventoryView.swift
//  Inventory
//
//  Created by Yehor Podolskyi on 26.05.2023.
//

import SwiftUI

struct InventoryView: View {
    
    @ObservedObject var state:StateManager
    
    
    func delete(at offsets: IndexSet) {
        state.inventory.remove(atOffsets: offsets)
        }
    
    var body: some View {
        List {
            ForEach(state.inventory, id: \.self) { item in
                VStack {
                    HStack{
                        Text("\(item.name)").font(.title2).bold()
                        Spacer()
                        item.type.map { type in
                            Text("\(item.type?.rawValue.capitalized ?? "")")
                        }
                        Spacer()
                        Text("Level: \(item.level)")
                            .padding()
                    }
                    HStack{
                        switch item.enchantment{
                        case let .isEnchanted(level: level):
                            Text("Enchanted").font(.title3).foregroundColor(.cyan)
                            Spacer()
                            Text("Level: \(level)").font(.title3).foregroundColor(.cyan)
                        case .common:
                            Text("Disenchanted").foregroundColor(.gray)
                            Spacer()
                        }
                    }
                }
            }
            .onDelete(perform: delete)
        }
        .popover(isPresented: $state.addPopOverIsShown) {
            if let unwrapped = $state.draft.unwrap(){
                NavigationView {
                    AddItemView(item: unwrapped)
                        .navigationTitle("Add new item")
                        .toolbar {
                            Button("Save") {
                                state.saveButtonPressed()
                            }
                        }
                }
                
                
            }
        }
    }
}


extension Binding {
  func unwrap<Wrapped>() -> Binding<Wrapped>? where Value == Wrapped? {
    guard let value = self.wrappedValue else { return nil }
    return Binding<Wrapped>(
      get: { value },
      set: { self.wrappedValue = $0 }
    )
  }
}


struct WrapperInventory: View{
    
    @ObservedObject var state = StateManager(inventory: [])
    var body: some View{
        NavigationView {
            InventoryView(state: state)
                .navigationTitle("Inventory")
                .toolbar {
                    Button("Add") {
                        state.addButtonPressed()
                    }
                }
        }
    }
    
}

struct InventoryView_Previews: PreviewProvider {
    static var previews: some View {
        WrapperInventory()
    }
}
