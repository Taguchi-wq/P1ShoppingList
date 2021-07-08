//
//  RealmManager.swift
//  P1ShoppingList
//
//  Created by cmStudent on 2021/07/03.
//  Copyright © 2021 cmStudent. All rights reserved.
//

import Foundation
import RealmSwift

/// Realmを管理するclass
final class RealmManager {
    
    // MARK: - initializer
    private init() {}
    
    // MARK: - Properties
    /// RealmManagerのインスタンスが一つであることを保証するshared
    static let shared = RealmManager()
    /// Realmのインスタンス
    private let realm = try! Realm()
    
    
    // MARK: - Private Methods
    /// Realm内に保存する
    private func write<T: Object>(_ object: T) {
        do {
            try realm.write { realm.add(object) }
        } catch {
            print(error)
        }
    }
    
    
    // MARK: - Methods
    /// Realmに保存されているデータを全て読み込む
    func loadAll<T: Object>(_ object: T.Type) -> Results<T>? {
        return realm.objects(T.self)
    }
    
    /// Realmに保存されているデータをプライマリーキーから読み込む
    func loadByPrimaryKey<T: Object>(_ object: T.Type, primaryKey: String) -> T? {
        return realm.object(ofType: T.self, forPrimaryKey: primaryKey)
    }
    
    /// Realmに保存されている「必要なモノ」のデータで、まだ買ってないものを読み込む
    func loadNeededProduct() -> Results<NeededProduct>? {
        return loadAll(NeededProduct.self)?.filter("boughtDate == nil")
    }
    
    /// Realmに保存されている「モノ」のデータをカテゴリーIDから読み込む
    func loadProductByCategoryID(_ categoryID: String) -> Results<Product>? {
        return loadAll(Product.self)?.filter("categoryID == '\(categoryID)'")
    }
    
    /// Realmに保存されている「必要なモノ」のデータをProductIDで読み込む
    func loadNeededProductByProductID(_ productID: String) -> NeededProduct? {
        return loadAll(NeededProduct.self)?.filter("productID == '\(productID)'").last
    }
    
    /// Realmにカテゴリーを保存する
    func writeCategory(_ category: Category) {
        write(category)
    }
    
    /// Realmにモノを保存する
    func writeProduct(_ product: Product) {
       write(product)
    }
    
    /// Realmに必要なモノを保存する
    func writeNeededProduct(_ neededProduct: NeededProduct) {
        write(neededProduct)
    }
    
    /// 「必要なモノ」を削除する(購入する)
    func deleteNeededProduct(_ neededProduct: NeededProduct) {
        do {
            try realm.write {
                neededProduct.boughtDate = Date()
            }
        } catch {
            print(error)
        }
    }
    
    /// モノの名前がかぶっているかを確認する
    func checkDuplicate(productName: String) -> Bool {
        let isDuplicate = loadAll(Product.self)!.filter("productName == '\(productName)'").isEmpty ? false : true
        return isDuplicate
    }
    
    /// 必要なものが削除(購入)されたかを確認する
    func checkDeleted(neededProduct: NeededProduct) -> Bool {
        let isDeleted = neededProduct.boughtDate == nil ? false : true
        return isDeleted
    }
    
}
