//
//  Product.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/06.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import Foundation
import RealmSwift

class Product: Object {
    @objc dynamic var productID   = NSUUID().uuidString
    @objc dynamic var categoryID  = String()
    @objc dynamic var productName = String()
    
    override static func primaryKey() -> String? {
        return "productID"
    }
}
