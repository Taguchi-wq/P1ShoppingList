//
//  RealmManager.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/03.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    var categoryCount: Int {
        do {
            let realm = try Realm()
            return realm.objects(Category.self).count
        } catch {
            print(error)
        }

        return 0
    }
    
    
    func loadAllThing() -> Results<Thing>? {
        do {
            let realm = try Realm()
            return realm.objects(Thing.self)
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func loadAllCategory() -> Results<Category>? {
        do {
            let realm = try Realm()
            return realm.objects(Category.self)
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func addCategory(_ category: Category) {
        do {
            let realm = try Realm()
            try realm.write { realm.add(category) }
        } catch {
            print(error)
        }
    }
    
    func addThing(_ thing: Thing) {
        do {
            let realm = try Realm()
            try realm.write { realm.add(thing) }
        } catch {
            print(error)
        }
    }
    
}
