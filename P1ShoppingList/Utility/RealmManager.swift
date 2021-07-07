//
//  RealmManager.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/03.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmManager {
    
    private init() {}
    static let shared = RealmManager()
    private let realm = try! Realm()
    
    
    func loadAll<T: Object>(_ object: T.Type) -> Results<T>? {
        return realm.objects(T.self)
    }
    
    func loadByPrimaryKey<T: Object>(_ object: T.Type, primaryKey: String) -> T? {
        return realm.object(ofType: T.self, forPrimaryKey: primaryKey)
    }
    
    private func write<T: Object>(_ object: T) {
        do {
            try realm.write { realm.add(object) }
        } catch {
            print(error)
        }
    }
    
    func loadNeededProduct() -> Results<NeededProduct>? {
        return loadAll(NeededProduct.self)?.filter("boughtDate == nil")
    }
    
    func loadProductByCategoryID(_ categoryID: String) -> Results<Product>? {
        return loadAll(Product.self)?.filter("categoryID == '\(categoryID)'")
    }
    
    func loadNeededProductByProductID(_ productID: String) -> NeededProduct? {
        return loadAll(NeededProduct.self)?.filter("productID == '\(productID)'").last
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
        let isDuplicate = loadAll(Product.self)!.filter("productName == '\(productName)'").isEmpty ? false : true
        return isDuplicate
    }
    
    func checkDeleted(neededProduct: NeededProduct) -> Bool {
        let neededProduct = loadByPrimaryKey(NeededProduct.self, primaryKey: neededProduct.neededProductID)
        let isDeleted = neededProduct?.boughtDate == nil ? false : true
        return isDeleted
    }
    
}
