//
//  NeededProduct.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/06.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import Foundation
import RealmSwift

class NeededProduct: Object {
    @objc dynamic var neededProductID   = NSUUID().uuidString
    @objc dynamic var productID         = String()
    @objc dynamic var registrationDate  = Date()
    @objc dynamic var boughtDate: Date? = nil
    
    override static func primaryKey() -> String? {
        return "neededProductID"
    }
}
