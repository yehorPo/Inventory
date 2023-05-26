//
//  Item.swift
//  Inventory
//
//  Created by Yehor Podolskyi on 26.05.2023.
//

import Foundation


struct Item : Hashable, Identifiable{

    var id = UUID()
    var name:String
    var level:Int
    var enchantment:Enchantment
    var type:ItemType?
    
    
    enum Enchantment : Hashable{
        case isEnchanted(level:Int)
        case common
        var level:Int{
            get{
                switch self{
                case let .isEnchanted(level:level): return level
                case .common: return 0
                }
            }
            set{
                self = .isEnchanted(level: newValue)
            }
        }
        
    }
    
    enum ItemType:String, CaseIterable, Hashable{
        case armor, weapon, potion, scroll, misc
    }

}
