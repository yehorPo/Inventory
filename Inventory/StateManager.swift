//
//  StateManager.swift
//  Inventory
//
//  Created by Yehor Podolskyi on 26.05.2023.
//

import Foundation



class StateManager:ObservableObject{
    @Published var inventory: [Item]
    @Published var draft:Item?
    @Published var addPopOverIsShown:Bool = false
    
    init(inventory: [Item], draft: Item? = nil) {
        self.inventory = inventory
        self.draft = draft
    }
    
    func addButtonPressed(){
        draft = Item(name: "", level: 1, enchantment: .common)
        addPopOverIsShown = true
    }
    func saveButtonPressed(){
        if let saveDraft = draft{
            inventory.append(saveDraft)
        }
        addPopOverIsShown = false
        draft = nil
    }
}


