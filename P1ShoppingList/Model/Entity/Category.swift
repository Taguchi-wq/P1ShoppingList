//
//  Category.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/03.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var categoryID   = NSUUID().uuidString
    @objc dynamic var categoryName = String()
    
    override static func primaryKey() -> String? {
        return "categoryID"
    }
}
