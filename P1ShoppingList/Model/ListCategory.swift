//
//  ListCategory.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/04.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import Foundation

public enum ListCategory {
    case dailyNecessities
    case food
    case clothes
    case other
    
    var category: String {
        switch self {
        case .dailyNecessities:
            return "日用品"
        case .food:
            return "食品"
        case .clothes:
            return "衣服"
        case .other:
            return "その他"
        }
    }
}
