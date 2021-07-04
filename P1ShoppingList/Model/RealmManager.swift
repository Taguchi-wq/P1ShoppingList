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
    
    private func loadAll<T: Object>(_ object: T.Type) -> Results<T>? {
        do {
            let realm = try Realm()
            return realm.objects(T.self)
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func write<T: Object>(_ object: T) {
        do {
            let realm = try Realm()
            try realm.write { realm.add(object) }
        } catch {
            print(error)
        }
    }
    
    func loadAllThing() -> Results<Thing>? {
        return loadAll(Thing.self)
    }
    
    func loadAllCategory() -> Results<Category>? {
        return loadAll(Category.self)
    }
    
    func loadThingByCategoryID(_ categoryID: String) -> Results<Thing>? {
        return loadAllThing()?.filter("categoryID == '\(categoryID)'")
    }
    
    func loadThingsNotDeleted() -> Results<Thing>? {
        return loadAllThing()?.filter("isDelete == false")
    }
    
    func writeCategory(_ category: Category) {
        write(category)
    }
    
    func writeThing(_ thing: Thing) {
       write(thing)
    }
    
}
