//
//  Thing.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/03.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import Foundation
import RealmSwift

class Thing: Object {
    @objc dynamic var thingID    = NSUUID().uuidString
    @objc dynamic var categoryID = String()
    @objc dynamic var createdAt  = Date()
    @objc dynamic var thingName  = String()
    @objc dynamic var deleteFlag = Bool()
    
    override static func primaryKey() -> String? {
        return "thingID"
    }
}
