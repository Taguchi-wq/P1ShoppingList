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
    
    private func loadByPrimaryKey<T: Object>(_ object: T.Type, _ primaryKey: String) -> T? {
        do {
            let realm = try Realm()
            return realm.object(ofType: T.self, forPrimaryKey: primaryKey)
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
    
    func loadAllProduct() -> Results<Product>? {
        return loadAll(Product.self)
    }
    
    func loadAllCategory() -> Results<Category>? {
        return loadAll(Category.self)
    }
    
    func loadNeededProduct() -> Results<NeededProduct>? {
        return loadAll(NeededProduct.self)?.filter("boughtDate == nil")
    }
    
    func loadProductByCategoryID(_ categoryID: String) -> Results<Product>? {
        return loadAllProduct()?.filter("categoryID == '\(categoryID)'")
    }
    
    func loadProductByPrimaryKey(_ primaryKey: String) -> Product? {
        return loadByPrimaryKey(Product.self, primaryKey)
    }
    
    func writeCategory(_ category: Category) {
        write(category)
    }
    
    func writeProduct(_ product: Product) {
       write(product)
    }
    
    func writeNeededProduct(_ neededProduct: NeededProduct) {
        write(neededProduct)
    }
    
    func deleteNeededProduct(_ neededProduct: NeededProduct) {
        do {
            let realm = try Realm()
            try realm.write {
                neededProduct.boughtDate = Date()
            }
        } catch {
            print(error)
        }
    }
    
    func checkDuplicate(productName: String) -> Bool {
        let isDuplicate = loadAllProduct()!.filter("productName == '\(productName)'").isEmpty ? false : true
        return isDuplicate
    }
    
}
